#!/usr/bin/env bash
set -eu -o pipefail

# Usage
# Go to the project you want to improve via this template
# cd ~/git/my-project
# Run this script from the working directory of that project
# ~/git/rust-binary-metafile-template/copy-template-into-existing-project.sh

git diff --quiet || (echo "repo unclean. stage or commit first" && exit 1)

name=$(basename "$PWD")
templatedir="$(dirname "$0")"

# Set the default of 1.63, the version on Debian bullseye
rustversion=$(rg --replace='$1' '^rust-version\s*=\s*"(.+)"$' Cargo.toml || echo "1.63")

featurecount=$(cargo metadata --no-deps --format-version=1 | jq ".packages.[].features|length")

rm -rf .github/workflows/
cp -r \
	"$templatedir/"{Cargo.toml,rustfmt.toml,.github,.gitignore,.dockerignore,Dockerfile,build.rs,systemd} \
	.

echo "everything copied"

sedi() {
	if [[ $OSTYPE = darwin* ]]; then
		sed -i '' "$@"
	else
		sed -i "$@"
	fi
}

# Replace template name with folder name
sedi "s/rust-binary-metafile-template/$name/g" Cargo.toml Dockerfile .github/**/*.yml systemd/**/*

sedi "s/rust-version = .*/rust-version = \"$rustversion\"/g" Cargo.toml
sedi "s/- \"1.74\"/- \"$rustversion\"/g" .github/**/*.yml

if ((featurecount == 0)); then
	sedi "s/ --all-features//g" .github/**/*.yml
fi

if compgen -G "**/lib.rs" >/dev/null; then
	echo "avoid-breaking-exported-api = false" >clippy.toml
fi

git --no-pager status --short
