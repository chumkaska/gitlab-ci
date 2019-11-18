#!/bin/bash
miss=$(coverage report --include="/usr*" | grep TOTAL | awk '{print$3}')
if [[ "$miss" -gt $2 ]]; then
    echo "Too many miss lines - $miss"
    exit 1
fi
for cover in $(coverage report --include="/usr*" | grep "/usr*" | awk '{print$4}' | sed 's/%//' )
do
    if [[ "$cover" -lt $1 ]]; then
        echo "Coverage is too thin - $cover"
        exit 1
    fi
done
exit 0
