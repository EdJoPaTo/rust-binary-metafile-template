#!/usr/bin/env bash
set -e

nice cargo build --release

# workdir
sudo mkdir -p /var/local/lib/rust-metafile-template/
sudo chown -R pi:pi /var/local/lib/rust-metafile-template/

# systemd
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -uv ./*.service ./*.timer /usr/local/lib/systemd/system/
sudo systemctl daemon-reload

# stop, replace and start new version
sudo systemctl stop rust-metafile-template.service rust-metafile-template.timer
sudo cp -v target/release/rust-metafile-template /usr/local/bin

# You probably only need one
sudo systemctl enable --now rust-metafile-template.service
sudo systemctl enable --now rust-metafile-template.timer
