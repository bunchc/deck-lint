#!/bin/bash

set -e

LOG_FILE="test_results.log"
CATEGORIES=("security" "observability" "governance" "operational-hygiene" "resilience-and-performance" "ai-gateway")
FAILURES=0

# Clear the log file
> "$LOG_FILE"

# Function to parse expected results from YAML comments
parse_expected_results() {
  local test_file="$1"
  local rule_name="$2"

  # This is a simplified parser. A more robust solution might use a dedicated YAML parser.
  grep "# Rule: $rule_name" "$test_file" | while read -r line; do
    if [[ "$line" == *" (negative)"* ]]; then
      echo "fail"
    elif [[ "$line" == *" (positive)"* ]]; then
      echo "pass"
    fi
  done
}

for category in "${CATEGORIES[@]}"
do
  echo "======================================================================"
  echo "Testing category: $category"
  echo "======================================================================"

  TEST_FILE="testing/$category.yaml"

  if [ ! -f "$TEST_FILE" ]; then
    echo "Test file $TEST_FILE not found. Skipping."
    continue
  fi

  RULE_FILES=$(find "$category" -name "*.yaml" ! -name "README.md")

  for rule_file in $RULE_FILES
  do
    rule_name=$(basename "$rule_file" .yaml)
    echo "----------------------------------------------------------------------"
    echo "Testing rule: $rule_name with $TEST_FILE"
    echo "----------------------------------------------------------------------"

    # Get expected results
    expected_results=($(parse_expected_results "$TEST_FILE" "$rule_name"))
    expected_pass=$(grep -o "pass" <<< "${expected_results[@]}" | wc -l)
    expected_fail=$(grep -o "fail" <<< "${expected_results[@]}" | wc -l)

    # Run linter and capture output
    output=$(deck file lint --fail-severity info --state "$TEST_FILE" "$rule_file" || true)

    # Parse actual results from the output summary
    violations=$(echo "$output" | grep -oP 'Linting Violations: \K[0-9]+' || echo "0")
    failures=$(echo "$output" | grep -oP 'Failures: \K[0-9]+' || echo "0")

    # For this script's purpose, we can treat all violations as failures.
    # A more sophisticated script could differentiate between severities.
    actual_fail=$failures

    # Calculate passes. This is tricky as the linter doesn't explicitly state passes.
    # We can count the number of entities in the test file and subtract failures.
    # As a simpler heuristic for now, if there are no failures, we assume everything that was supposed to pass did.
    # This is imperfect but better than the current state.

    total_expected=$(($expected_pass + $expected_fail))
    actual_pass=$((total_expected - actual_fail))
    if [ $actual_pass -lt 0 ]; then
      actual_pass=0
    fi

    echo "Expected: Pass=$expected_pass, Fail=$expected_fail"
    echo "Actual:   Pass=$actual_pass, Fail=$actual_fail"

    # Compare results
    if [ "$actual_pass" -ne "$expected_pass" ] || [ "$actual_fail" -ne "$expected_fail" ]; then
      echo "Discrepancy found for rule: $rule_name" | tee -a "$LOG_FILE"
      echo "Expected: Pass=$expected_pass, Fail=$expected_fail" | tee -a "$LOG_FILE"
      echo "Actual:   Pass=$actual_pass, Fail=$actual_fail" | tee -a "$LOG_FILE"
      echo "Linter output:" | tee -a "$LOG_FILE"
      echo "$output" | tee -a "$LOG_FILE"
      echo "" | tee -a "$LOG_FILE"
      FAILURES=$((FAILURES + 1))
    fi
  done
done

if [ "$FAILURES" -gt 0 ]; then
  echo "======================================================================"
  echo "$FAILURES test(s) failed. Check $LOG_FILE for details."
  echo "======================================================================"
  exit 1
else
  echo "======================================================================"
  echo "All tests passed successfully."
  echo "======================================================================"
  exit 0
fi
