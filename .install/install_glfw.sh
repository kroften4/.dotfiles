#!/usr/bin/env bash

# clone GLFW
git clone https://github.com/glfw/glfw
pushd glfw
git checkout 3.4

# apply the patches
curl -o glfw.patch https://raw.githubusercontent.com/tesselslate/waywall/be3e018bb5f7c25610da73cc320233a26dfce948/contrib/glfw.patch
git apply glfw.patch

# compile GLFW
cmake -S . -B build -DBUILD_SHARED_LIBS=ON -DGLFW_BUILD_WAYLAND=ON
pushd build
make

DESTINATION=$HOME/.local/lib64/
mkdir -p $DESTINATION
mv src/libglfw.so* $DESTINATION
popd
popd
rm -rf glfw/

