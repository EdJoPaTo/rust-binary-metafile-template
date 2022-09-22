#!/usr/bin/env bash
set -eu

dir=$(basename "$(pwd)")
if [ "$dir" == "systemd" ] || [ "$dir" == "system" ]; then
    echo "run from main directiory like this: ./systemd/system/install.sh"
    exit 1
fi

nice cargo build --release --locked

# systemd
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -v systemd/system/service "/usr/local/lib/systemd/system/rust-binary-metafile-template.service"
sudo cp -v systemd/system/timer "/usr/local/lib/systemd/system/rust-binary-metafile-template.timer"
sudo cp -v systemd/system/sysuser "/usr/lib/sysusers.d/rust-binary-metafile-template.conf"
sudo cp -v systemd/system/tmpfile "/usr/lib/tmpfiles.d/rust-binary-metafile-template.conf"
sudo systemd-sysusers
sudo systemd-tmpfiles --create
sudo systemctl daemon-reload

# stop, replace and start new version
sudo systemctl stop "rust-binary-metafile-template.service" "rust-binary-metafile-template.timer"
sudo cp -v "target/release/rust-binary-metafile-template" /usr/local/bin

# You probably only need one
sudo systemctl enable --now "rust-binary-metafile-template.service"
sudo systemctl enable --now "rust-binary-metafile-template.timer"
