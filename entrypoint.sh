#!/bin/sh -l

echo "Domains: $1"
echo "URLs: $2"
echo "Cookies: $3"

if [ -z "$1" -a -z "$2" ]; then
  echo "You must provide at least 1 domain or 1 url!"
  exit 1
fi

git clone --depth=1 https://github.com/GerbenJavado/LinkFinder.git /tmp/LinkFinder
pip3 install -r /tmp/LinkFinder/requirements.txt

if [ -n "$1" ]; then
  echo "$1" | tr " " "\n" | while read domain; do
    echo "Analyzing: ${domain}"
    python3 /tmp/LinkFinder/linkfinder.py -d -o cli -c "$3" -i "https://${domain}" > "$(echo ${domain} | tr . _).txt"
  done
fi

if [ -n "$2" ]; then
  echo "$2" | tr " " "\n" | while read url; do
    echo "Analyzing: ${url}"
    python3 /tmp/LinkFinder/linkfinder.py -o cli -c "$3" -i "${url}" > "$(echo ${url} | tr -c '[:alnum:]' _).txt"
  done
fi
