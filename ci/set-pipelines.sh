#!/bin/bash

target=cff-tutorials	
this_directory=$(dirname "$0")

fly -t $target sp -p landing-page -c ${this_directory}/landing/pipeline.yml --non-interactive

fly -t $target sp -p what-is-cf -c ${this_directory}/tutorial/pipeline.yml -l ${this_directory}/tutorial/configs/what-is-cf.yml --non-interactive

fly -t $target sp -p trycf -c ${this_directory}/tutorial/pipeline.yml -l ${this_directory}/tutorial/configs/trycf.yml --non-interactive
