#/bin/sh
pushd ~/flake
nix build .#homeManagerConfigurations.vboob.activationPackage
./result/activate
popd
