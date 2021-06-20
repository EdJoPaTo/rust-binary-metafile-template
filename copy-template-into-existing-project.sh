#!/usr/bin/env bash
set -e

# Usage
# Go to the project you want to improve via this template
# cd ~/git/my-project
# Run this script from the working directory of that project
# ~/git/rust-binary-metafile-template/copy-template-into-existing-project.sh

pwd=$(pwd)
name=$(basename "$pwd")

cd "$(dirname "$0")"

cp -rv \
    {Cargo.toml,.gitignore,.github,.dockerignore,Dockerfile,build.rs,systemd} \
    "$pwd"

cp -rv \
    src/cli.rs \
    "$pwd/src"

echo "everything copied"

cd -

# Replace template name with folder name
# macOS: add '' after -i like this: sed -i '' "s/…
sed -i "s/rust-binary-metafile-template/$name/g" Cargo.toml Dockerfile .github/**/*.yml systemd/*

git --no-pager diff --stat
