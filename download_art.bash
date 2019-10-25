#!/bin/bash
JOB_ID=$(curl -k --location --header "PRIVATE-TOKEN: $MY_TOKEN" "https://gitlab-my.ru/api/v4/projects/$CI_PROJECT_ID/repository/commits/$CI_COMMIT_SHA/statuses" | jq '.[] | select(.name == "build" and .status == "success") | .id')
echo "$JOB_ID"
if [ -z "$JOB_ID" ]; then
  echo "build failed"
  exit 1
else 
        curl -k --output my_art.art --location --header "PRIVATE-TOKEN: $MY_TOKEN" "https://gitlab-my.ru/api/v4/projects/$CI_PROJECT_ID/jobs/$JOB_ID/artifacts/my_art.art"
fi
exit 0
