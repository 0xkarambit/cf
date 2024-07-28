#!/bin/bash

# shellcheck source=./common.sh
source ./common.sh

[[ $# -eq 1 ]] || {
    error '[USAGE]: fetch_problem.sh <codeforces_problem_url>'
    exit 1
}

url="$1"

# checking if its a valid url
PROBLEM_URL_PATTERN="^https://codeforces\.com/contest/([0-9]{4})/problem/([A-Z0-9]+)$"
if [[ ! "$url" =~ $PROBLEM_URL_PATTERN ]]; then
    error "Not a codeforces contest problem url"
    exit 1
fi

contest_id="${BASH_REMATCH[1]}"
problem_id="${BASH_REMATCH[2]}"

echo "fetching problem $problem_id"
response=$(curl "$url" --silent)
if [ $? -ne 0 ]; then
    error "Couldn't fetch problem $problem_id $url"
    exit 1
fi

cd "$contest_id" || exit 1

# filtering and writing input to `./input/$problem_id`
echo -n "$response" |
    pup '.input > pre text{}' |
    sed -e '1d' >"./input/$problem_id"

# filtering and writing expected output to `./exp_output/$problem_id`
echo -n "$response" |
    pup '.output > pre text{}' |
    tr ' ' '\n' |
    sed -e '1d;$d' >"./exp_output/$problem_id"
