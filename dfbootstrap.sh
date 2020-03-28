#!/bin/bash

platform=""

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  platform="LINUX"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  platform="MACOS"
else
  echo "Valid platform not detected. Aborting."
  exit 1;
fi

command -v perl >/dev/null || {
  echo >&2 "Perl not installed. Please install Perl before continuing."
  exit 1;
}

if [[ -n "$platform" ]]
then
  perl dfbootstrap.pl -p $platform
else
  echo "Valid platform not detected. Aborting."
fi
