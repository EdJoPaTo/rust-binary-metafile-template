#!/usr/bin/env bash
set -eu

# Usage
# Go to the project you want to improve via this template
# cd ~/git/my-project
# Run this script from the working directory of that project
# ~/git/rust-binary-metafile-template/copy-template-into-existing-project.sh

name=$(basename "$PWD")
templatedir="$(dirname "$0")"

rm -rf .github/workflows/
cp -r \
    "$templatedir/"{Cargo.toml,.github,.gitignore,.dockerignore,Dockerfile,build.rs,systemd} \
    .

cp "$templatedir/src/cli.rs" "./src"

echo "everything copied"

# Replace template name with folder name
# macOS: add '' after -i like this: sed -i '' "s/…
sed -i "s/rust-binary-metafile-template/$name/g" Cargo.toml Dockerfile .github/**/*.yml systemd/**/*

git --no-pager status --short
