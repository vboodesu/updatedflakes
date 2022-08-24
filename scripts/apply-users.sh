#/bin/sh
pushd ~/updatedflakes
nix build .#homeManagerConfigurations.vboob.activationPackage
./result/activate
popd
