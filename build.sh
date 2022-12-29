#!/bin/bash

# For cross compilation to all supported targets, macOS host is recommended
# Success on other hosts is not guaranteed

mkdir build
rm -r build/out
mkdir build/out

SCRIPTPATH=$(dirname "$SCRIPT")

# Change with path to latest macOS SDK
SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"

if [ -e "${SDKROOT}" ]
then
    echo "macOS SDK 12.0 found!"
else
    echo "macOS SDK 12.0 not found!"
    #echo "Downloading..."
    #wget https://github.com/hexops/sdk-macos-12.0/archive/refs/heads/main.zip -o build/sdk.zip
    #unzip build/sdk.zip -d build
fi

# Build for x86_64-linux
echo "Building for x86_64-linux..."
CGO_ENABLED=1 GOOS=linux GOARCH=amd64 CC="zig cc -target x86_64-linux" CXX="zig c++ -target x86_64-linux" go build -buildmode=c-archive -o build/out/libboptimizer-x86_64-linux.a -ldflags="-w" src/main.go

# Build for aarch64-linux
echo "Building for aarch64-linux..."
CGO_ENABLED=1 GOOS=linux GOARCH=arm64 CC="zig cc -target aarch64-linux" CXX="zig c++ -target aarch64-linux" go build -buildmode=c-archive -o build/out/libboptimizer-aarch64-linux.a -ldflags="-w" src/main.go

# Build for aarch64-macos
echo "Building for aarch64-macos..."
CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 CC="zig cc --sysroot=${SDKROOT} -L${SDKROOT}/usr/lib -F${SDKROOT}/System/Library/Frameworks -target aarch64-macos" CXX="zig c++ --sysroot=${SDKROOT} -L${SDKROOT}/usr/lib -F${SDKROOT}/System/Library/Frameworks -target aarch64-macos" go build -buildmode=c-archive -o build/out/libboptimizer-aarch64-macos.a -ldflags="-w" src/main.go

# Build for x86_64-macos
echo "Building for x86_64-macos..."
CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 CC="zig cc --sysroot=${SDKROOT} -L${SDKROOT}/usr/lib -F${SDKROOT}/System/Library/Frameworks -target x86_64-macos" CXX="zig c++ --sysroot=${SDKROOT} -L${SDKROOT}/usr/lib -F${SDKROOT}/System/Library/Frameworks -target x86_64-macos" go build -buildmode=c-archive -o build/out/libboptimizer-x86_64-macos.a -ldflags="-w" src/main.go
