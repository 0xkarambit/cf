#!/bin/bash

source ./common.sh

# checking if provided url is a valid contest url
URL_PATTERN="^https://codeforces\.com/contest/([0-9]{4})/?$"
if [[ "$#" -ne 1 || ! "$1" =~ $URL_PATTERN ]]; then
    error "Not a codeforces contest problem url"
    exit 1
fi

contest_id="${BASH_REMATCH[1]}"

echo "Fetching problem $contest_id"

# Setup directory structure
if [[ ! -d "$contest_id" ]]; then
    mkdir "$contest_id" || exit 1
    mkdir "$contest_id/input" "$contest_id/output" "$contest_id/exp_output" || exit 1
fi

res=$(
    curl "$1" \
        --silent \
        --compressed -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0' \
        -H 'Accept: text/html' \
        -H 'Accept-Language: en-US,en;q=0.5' \
        -H 'Accept-Encoding: gzip, deflate, br, zstd' \
        -H 'DNT: 1' \
        -H 'Upgrade-Insecure-Requests: 1' \
        -H 'Sec-Fetch-Dest: document' \
        -H 'Sec-Fetch-Mode: navigate' \
        -H 'Sec-Fetch-Site: cross-site' \
        -H 'Connection: keep-alive'
)

if [ $? -ne 0 ]; then
    error "Couldn't fetch $1"
    exit 1
fi

contest_ids=$(
    echo -n "$res" |
        pup ".problems tr:not(:first-child) > td.id text{}" |
        awk 'NF' |
        tr -cd '[:alnum:]\n'
)

path="$(dirname "$(realpath "$0")")/fetch_problem.sh"

echo -n "$contest_ids" |
    xargs -I % bash -c "$path https://codeforces.com/contest/$contest_id/problem/%"
