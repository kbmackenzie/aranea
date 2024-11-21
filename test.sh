#!/bin/sh

# A simple file-oriented test suite for Aranea.
SCRIPT='./src/aranea.awk'

echo_error() {
  echo "$1" 1>&2
}

TEST_LIST=$(ls ./test)
TEST_COUNT=$(echo "$TEST_LIST" | wc -l)
FAIL_COUNT=0

echo "Running tests..."

for TEST in $TEST_LIST; do
  TEST_PATH="./test/${TEST}"

  # Compare program output with expected output through 'diff'.
  # When the two differ, this means a test failed.
  $SCRIPT "${TEST_PATH}/run.sh" | diff - "${TEST_PATH}/expect.sh"

  if [ $? -ne 0 ]; then
    FAIL_COUNT=$((FAIL_COUNT + 1))
    echo_error "Test \"${TEST}\" failed!"
    exit 1
  fi
done

if [ $FAIL_COUNT -gt 0 ]; then
  echo_error "$((TEST_COUNT - FAIL_COUNT)) passed, $FAIL_COUNT failed"
  exit 1
else
  echo "All tests passed."
fi
