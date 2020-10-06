#!/bin/bash

set -ex

version=$(cat version/version)
tutorial_commit_hash=$(cat tutorial-source/.git/ref)
theme_commit_hash=$(cat theme-source/.git/ref)
year=$(date +%Y)

echo "Building tutorial version: ${version}"

echo "Building tutorial ${SOURCE_REPO_NAME} version: ${version}, commit hash: ${commit_hash}, theme commit hash: ${theme_commit_hash}"

mkdir build
cd build
hugo new site .

cp -R ../tutorial-source/content/* content
if [ -d "../tutorial-source/static" ]; then
	cp -R ../tutorial-source/static/* static/*
fi

mkdir themes/hugo-whisper-theme
cp -R ../theme-source/* themes/hugo-whisper-theme

# config.yml
rm config.toml
cp ../ci-source/ci/tutorial/hugo-config.yml config.yml
sed -i "s/((title))/${TITLE}/g" config.yml
sed -i "s/((source_repo_name))/${SOURCE_REPO_NAME}/g" config.yml
sed -i "s/((meta_description))/${META_DESCRIPTION}/g" config.yml
#echo 'version: "'${version}'"' >> config.yml

hugo

cd ..
mkdir -p to_zip/${SOURCE_REPO_NAME}
cp -R build/public/* to_zip/${SOURCE_REPO_NAME}
echo "pushstate: enabled" > to_zip/Staticfile
echo "force_https: true" >> to_zip/Staticfile
artifact_name="${SOURCE_REPO_NAME}-${version}.zip"
pushd to_zip
	zip -r ${artifact_name} * -x "*.DS_Store"
	mv ${artifact_name} ../site
popd

#unzip -vl site/*.zip




# Tutorial Info

# tutorial version
# commit hash .git/ref
# last commit message .git/commit_message

# theme version
# theme link