#!/bin/sh
pushd ~/flake
sudo nixos-rebuild switch --flake .#
popd
