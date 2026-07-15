#!/bin/bash

# Minimal Bash Unit Testing Framework
# Tests use exit codes: 0 = pass, non-zero = fail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_LIST=()

# Assertions file
ASSERTIONS_FILE=assertions.json

# Version information
PREVIOUS_VERSION_TAG=v4.0
PREVIOUS_VERSION_XSL=to40.xsl

# Run a single test function
run_test() {
    local test_name=$1
    echo -ne "Testing: $test_name ... "
    ((TESTS_RUN++))

    # Execute the test function and capture exit code
    if $test_name; then
        echo -e "${GREEN}PASS${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}FAIL${NC}"
        ((TESTS_FAILED++))
        TESTS_LIST+=($test_name)
    fi
}

# Get assertion expectation of test and schema
# The default behaviour is:
# - Expect a "pass" for validation with *.xsd
# - Expect to "skip" for validation with *.sch
get_assertion() {
    echo $(jq -r --arg test "$1" --arg schema "$2" '.[$test][$schema] // (if $schema | endswith(".xsd") then "pass" else "skip" end)' "$ASSERTIONS_FILE")
}

# Get Schematron validations for given test
get_validations() {
  jq -r --arg test "$1" '(.[$test] // {}) | keys[] | select(endswith(".sch"))' "$ASSERTIONS_FILE"
}

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_001_schema_valid() {
    #
    # Verify that all MusicXML XSD schemas are syntactically correct.
    #
    XML_CATALOG_FILES=./catalog.xml xmllint --schema XMLSchema.xsd ../schema/musicxml.xsd --noout || return $?
    XML_CATALOG_FILES=./catalog.xml xmllint --schema XMLSchema.xsd ../schema/container.xsd --noout || return $?
    XML_CATALOG_FILES=./catalog.xml xmllint --schema XMLSchema.xsd ../schema/opus.xsd --noout || return $?
    XML_CATALOG_FILES=./catalog.xml xmllint --schema XMLSchema.xsd ../schema/sounds.xsd --noout || return $?
}

test_002_suite_syntax() {
    #
    # Verify that all MusicXML files in the test suite are syntactically correct.
    #
    find -L files \( -name '*.xml' -o -name '*.musicxml' \) -print0 | sort -z | while read -d $'\0' file
    do
        local assert=$(get_assertion "$(basename "$file")" "musicxml.xsd")
        if [[ $assert == "skip" ]]; then continue; fi

        XML_CATALOG_FILES=../schema/catalog.xml xmllint --schema ../schema/musicxml.xsd "$file" --noout
        local status=$?
        if [[ $assert == "fail" && $status == 0 ]]; then
            echo -e "$file" is expected to fail
            exit 1 # exit not return because the pipe opens a subshell
        elif [[ $assert == "pass" && $status != 0 ]]; then
            exit $status
        fi
    done
}

test_003_suite_schematron() {
    #
    # Verify that all MusicXML files in the test suite pass the semantic validations.
    #
    find -L files \( -name '*.xml' -o -name '*.musicxml' \) -print0 | sort -z | while read -d $'\0' file
    do
        while IFS= read -r schema; do
            local assert=$(get_assertion "$(basename "$file")" "$schema")
            if [[ $assert == "skip" ]]; then continue; fi

            ./schematron.py "validations/$schema" "$file" --noout
            local status=$?
            if [[ $assert == "fail" && $status == 0 ]]; then
                echo -e "$file" is expected to fail
                exit 1 # exit not return because the pipe opens a subshell
            elif [[ $assert == "pass" && $status != 0 ]]; then
                exit $status
            fi
        done < <(get_validations "$(basename "$file")")
    done
}

test_004_previous_version() {
    #
    # Verify that toXY.xsl transformation works and validates against the corresponding git tag vX.Y of the schema.
    #
    local tempdir=$(mktemp -d)
    trap "rm -rf $tempdir" 0 1 2 3 15   # clean up on exit
    GIT_INDEX_FILE="$tempdir/git" GIT_WORK_TREE="$tempdir" git checkout "$PREVIOUS_VERSION_TAG" -- schema

    find -L files \( -name '*.xml' -o -name '*.musicxml' \) -print0 | sort -z | while read -d $'\0' file
    do
        local assert=$(get_assertion "$(basename "$file")" "$PREVIOUS_VERSION_XSL")
        if [[ $assert == "skip" ]]; then continue; fi

        local previous="$tempdir/$(basename "$file")"
        XML_CATALOG_FILES=../schema/catalog.xml xsltproc "../schema/$PREVIOUS_VERSION_XSL" "$file" > "$previous" || exit $?
        XML_CATALOG_FILES="$tempdir/schema/catalog.xml" xmllint --schema "$tempdir/schema/musicxml.xsd" "$previous" --noout
        local status=$?
        if [[ $assert == "fail" && $status == 0 ]]; then
            echo -e "$file" is expected to fail
            exit 1 # exit not return because the pipe opens a subshell
        elif [[ $assert == "pass" && $status != 0 ]]; then
            exit $status
        fi
    done
}

# ============================================================================
# TEST RUNNER
# ============================================================================

main() {
    echo "=========================================="
    echo "Running Unit Tests"
    echo "=========================================="
    echo ""

    # Discover all test_* functions and run them
    while IFS= read -r test_name; do
        if [[ -z "$TEST_NAME" || "$test_name" =~ "$TEST_NAME" ]]; then
            run_test "$test_name"
        fi
    done < <(declare -F | awk '{print $3}' | grep '^test_' | sort)

    # Print summary
    echo ""
    echo "=========================================="
    echo "Test Summary"
    echo "=========================================="
    echo "Total tests: $TESTS_RUN"
    echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
    echo ""

    # Exit with appropriate code
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some tests failed:${NC} ${TESTS_LIST[*]}"
        exit 1
    fi
}

main "$@"