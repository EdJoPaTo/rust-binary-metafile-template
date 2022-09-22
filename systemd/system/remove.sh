#!/usr/bin/env bash

sudo systemctl disable --now "rust-binary-metafile-template.timer" "rust-binary-metafile-template.service"

sudo rm -f "/usr/lib/tmpfiles.d/rust-binary-metafile-template.conf"
sudo rm -f "/usr/lib/sysusers.d/rust-binary-metafile-template.conf"
sudo rm -f "/usr/local/lib/systemd/system/rust-binary-metafile-template.service"
sudo rm -f "/usr/local/lib/systemd/system/rust-binary-metafile-template.timer"
sudo rm -f "/usr/local/bin/rust-binary-metafile-template"

sudo userdel -r "rust-binary-metafile-template"
sudo groupdel "rust-binary-metafile-template"

sudo systemctl daemon-reload


echo "/var/local/lib/rust-binary-metafile-template/ is not touched and is still existing"
