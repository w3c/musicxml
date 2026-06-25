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
    fi
}

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_schema_valid() {
    xmllint --schema XMLSchema.xsd ../schema/musicxml.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/container.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/opus.xsd --noout || return $?
    xmllint --schema XMLSchema.xsd ../schema/sounds.xsd --noout || return $?
}

test_suite_valid() {
    tmp=$(mktemp -d)
    sed 's|schemaLocation="http://www.musicxml.org/xsd/|schemaLocation="|g' ../schema/musicxml.xsd > "$tmp/musicxml.xsd"
    cp ../schema/xlink.xsd ../schema/xml.xsd "$tmp"
    find musicxmlTestSuite -name '*.xml' -print0 | while read -d $'\0' file
    do
        xmllint --schema "$tmp/musicxml.xsd" "$file" --noout || return $?
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
        echo -e "${RED}Some tests failed.${NC}"
        exit 1
    fi
}

main "$@"