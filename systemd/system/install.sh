#!/usr/bin/env bash
set -e

name="rust-binary-metafile-template"

dir=$(basename "$(pwd)")
if [ "$dir" == "systemd" ] || [ "$dir" == "system" ]; then
    echo "run from main directiory like this: ./systemd/system/install.sh"
    exit 1
fi

nice cargo build --release --locked

# systemd
sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -v "systemd/system/service" "/usr/local/lib/systemd/system/$name.service"
sudo cp -v "systemd/system/timer" "/usr/local/lib/systemd/system/$name.timer"
sudo cp -v "systemd/system/sysuser" "/usr/lib/sysusers.d/$name.conf"
sudo cp -v "systemd/system/tmpfile" "/usr/lib/tmpfiles.d/$name.conf"
sudo systemd-sysusers
sudo systemd-tmpfiles --create
sudo systemctl daemon-reload

# stop, replace and start new version
sudo systemctl stop "$name.service" "$name.timer"
sudo cp -v "target/release/$name" /usr/local/bin

# You probably only need one
sudo systemctl enable --now "$name.service"
sudo systemctl enable --now "$name.timer"
