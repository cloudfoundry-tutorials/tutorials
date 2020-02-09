#!/bin/bash

set -e

version=$(cat version/version)
commit_hash=$(cat page-source/.git/ref)
source_link="https://github.com/cloudfoundry-tutorials/tutorials/commit/${commit_hash}"

echo "Building tutorial landing page version: ${version} commit hash: ${commit_hash}"

pushd page-source/landing-page
	sed -i "s/((version))/${version}/g" index.html
	sed -i "s/((source))/${source_link}/g" index.html

  artifact_name="landing-page-${version}.zip"
	zip -r ${artifact_name} * -x "*.DS_Store" -x "*-manifest.yml"
	mv ${artifact_name} ../../site
popd
