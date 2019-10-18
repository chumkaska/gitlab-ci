#!/bin/bash
check_fail=$(curl -k --location --header "PRIVATE-TOKEN: $MY_TOKEN" "https://gitlab-my.ru/api/v4/projects/$CI_PROJECT_ID/repository/commits/$CI_COMMIT_SHA/statuses" | jq '.[] | select(.name != "check_status") | select(.status == "pending" or .status == "failed" or .status == "running" or .status == "canceled")')
echo "$check_fail"
if [ -n "$check_fail" ]; then
  echo "failed or running or pendingi or canceled"
  exit 1
fi
exit 0
