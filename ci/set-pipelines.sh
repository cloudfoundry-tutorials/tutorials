#!/bin/bash

target=cff-tutorials	
this_directory=$(dirname "$0")

fly -t $target sp -p landing-page -c ${this_directory}/landing/pipeline.yml --non-interactive
