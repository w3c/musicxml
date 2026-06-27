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

ASSERTIONS_FILE=assertions.json

# Get assertion expectation of test and schema
# The default behaviour is:
# - Expect a "pass" for validation with *.xsd
# - Expect to "skip" for validation with *.sch
get_assertion() {
    echo $(jq -r --arg test "$1" --arg schema "$2" '.[$test][$schema] // (if $schema | endswith(".sch") then "skip" else "pass" end)' $ASSERTIONS_FILE)
}

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_001_schema_valid() {
    #
    # Verify that all MusicXML XSD schemas are syntactically correct.
    #
    xmllint --schema XMLSchema.xsd ../schema/musicxml.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/container.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/opus.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/sounds.xsd --noout || return $?
}

test_002_suite_syntax() {
    #
    # Verify that all MusicXML files in the test suite are syntactically correct.
    # - Files with .invalid.xml are expected to fail
    # - The schema musicxml.xsd needs to be "fudged" to update the location of the complementary schemas xlink.xsd and xml.xsd
    #   @see https://github.com/w3c-cg/musicxml/discussions/445
    #
    local temp=$(mktemp -d)
    awk '{gsub(/schemaLocation="http:\/\/www\.musicxml\.org\/xsd\//, "schemaLocation=\""); print}' ../schema/musicxml.xsd > "$temp/musicxml.xsd"
    cp ../schema/xlink.xsd ../schema/xml.xsd "$temp"
    find musicxmlTestSuite -name '*.xml' -print0 | sort -z | while read -d $'\0' file
    do
        local assert=$(get_assertion "$(basename "$file")" "musicxml.xsd")
        if [[ $assert == "skip" ]]; then continue; fi

        xmllint --schema "$temp/musicxml.xsd" "$file" --noout
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
    # - Files are associated with a Schematron schema by appending the schema filename
    # - Files are expected to pass syntactic validation
    # - Files with .fail.xml are expected to fail the semantic validation
    #
    find validations -name '*.sch' -print0 | sort -z | while read -d $'\0' schema
    do
        find musicxmlTestSuite -name '*.xml' -print0 | sort -z | while read -d $'\0' file
        do
            local assert=$(get_assertion "$(basename "$file")" "$(basename "$schema")")
            if [[ $assert == "skip" ]]; then continue; fi

            ./schematron.py "$schema" "$file" --noout
            local status=$?
            if [[ $assert == "fail" && $status == 0 ]]; then
                echo -e "$file" is expected to fail
                exit 1 # exit not return because the pipe opens a subshell
            elif [[ $assert == "pass" && $status != 0 ]]; then
                exit $status
            fi
        done
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
        run_test "$test_name"
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