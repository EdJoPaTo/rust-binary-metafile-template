#!/usr/bin/env bash
set -e

# Usage
# Go to the project you want to improve via this template
# cd ~/git/my-project
# Run this script from the working directory of that project
# ~/git/rust-metafile-template/copy-template-into-existing-project.sh

pwd=$(pwd)
name=$(basename "$pwd")

cd "$(dirname "$0")"

cp -rv \
    {Cargo.toml,.gitignore,.github,.dockerignore,Dockerfile,build.rs,install-systemd.sh} \
    "$pwd"

cp -rv \
    src/cli.rs \
    "$pwd/src"

cp -rv rust-metafile-template.service "$pwd/$name.service"
cp -rv rust-metafile-template.timer "$pwd/$name.timer"

echo "everything copied"

cd -

# Replace template name with folder name
sed -i '' "s/rust-metafile-template/$name/g" Cargo.toml Dockerfile .github/**/*.yml install-systemd.sh ./*.service ./*.timer

git --no-pager diff --stat
