#!/bin/bash
pattern='\.(c|cpp|cc|cxx|h|hpp)$'

changed_files=$(git diff --name-only origin/${CI_MERGE_REQUEST_TARGET_BRANCH_NAME} | grep -E $pattern)

echo "$changed_files"
if [ -z "$changed_files" ]; then
  exit 0
else
  cppcheck --quiet --error-exitcode=1 $changed_files $@
  exit $?
fi
