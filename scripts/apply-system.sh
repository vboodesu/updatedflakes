#!/bin/sh
pushd ~/flake
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix 
popd
