#!/bin/bash

this_directory=$(dirname "$0")

pushd $this_directory
  cf push -p ../landing-page  -f ./manifest.yml
popd