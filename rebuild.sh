#!/bin/sh
nixos-rebuild switch --flake /etc/nixos#nixos-to-go --log-format internal-json -v |& nom --json
