#!/bin/sh -x

# 张小龙的马
#mkdir -p /tmp/switch-system
#cd /tmp/switch-system
#wget https://aur.archlinux.org/cgit/aur.git/plain/license.tar.gz\?h\=wechat-uos-bwrap -o license.tar.gz
#nix store add-file license.tar.gz

nixos-rebuild switch --flake /etc/nixos#nixos-to-go --log-format internal-json -vv |& nom --json
