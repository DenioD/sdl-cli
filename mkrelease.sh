#!/bin/bash
# This script depends on a docker image already being built
# To build it, 
# cd docker
# docker build --tag rustbuild:latest .

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--version)
    APP_VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -z $APP_VERSION ]; then echo "APP_VERSION is not set"; exit 1; fi

# Write the version file
echo "pub const VERSION:&str = \"$APP_VERSION\";" > /cli/src/version.rs

# First, do the tests
cd lib && cargo test --release
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error"
    exit $retVal
fi
cd ..

# Compile for mac directly
cargo build --release 

#macOS
rm -rf target/macOS-silentdragonlite-cli-v$APP_VERSION
mkdir -p target/macOS-silentdragonlite-cli-v$APP_VERSION
cp target/release/silentdragonlite-cli target/macOS-silentdragonlite-cli-v$APP_VERSION/

# For Windows and Linux, build via docker
docker run --rm -v $(pwd)/:/opt/silentdragonlite-cli rustbuild:latest bash -c "cd /opt/silentdragonlite-cli && cargo build --release && cargo build --release --target armv7-unknown-linux-gnueabihf && cargo build --release --target aarch64-unknown-linux-gnu && SODIUM_LIB_DIR='/opt/libsodium-win64/lib/' cargo build --release --target x86_64-pc-windows-gnu"

# Now sign and zip the binaries
# macOS
gpg --batch --output target/macOS-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.sig --detach-sig target/macOS-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli 
cd target
cd macOS-silentdragonlite-cli-v$APP_VERSION
gsha256sum silentdragonlite-cli > sha256sum.txt
cd ..
zip -r macOS-silentdragonlite-cli-v$APP_VERSION.zip macOS-silentdragonlite-cli-v$APP_VERSION 
cd ..


#Linux
rm -rf target/linux-silentdragonlite-cli-v$APP_VERSION
mkdir -p target/linux-silentdragonlite-cli-v$APP_VERSION
cp target/release/silentdragonlite-cli target/linux-silentdragonlite-cli-v$APP_VERSION/
gpg --batch --output target/linux-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.sig --detach-sig target/linux-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli
cd target
cd linux-silentdragonlite-cli-v$APP_VERSION
gsha256sum silentdragonlite-cli > sha256sum.txt
cd ..
zip -r linux-silentdragonlite-cli-v$APP_VERSION.zip linux-silentdragonlite-cli-v$APP_VERSION 
cd ..


#Windows
rm -rf target/Windows-silentdragonlite-cli-v$APP_VERSION
mkdir -p target/Windows-silentdragonlite-cli-v$APP_VERSION
cp target/x86_64-pc-windows-gnu/release/silentdragonlite-cli.exe target/Windows-silentdragonlite-cli-v$APP_VERSION/
gpg --batch --output target/Windows-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.sig --detach-sig target/Windows-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.exe
cd target
cd Windows-silentdragonlite-cli-v$APP_VERSION
gsha256sum silentdragonlite-cli.exe > sha256sum.txt
cd ..
zip -r Windows-silentdragonlite-cli-v$APP_VERSION.zip Windows-silentdragonlite-cli-v$APP_VERSION 
cd ..


#Armv7
rm -rf target/Armv7-silentdragonlite-cli-v$APP_VERSION
mkdir -p target/Armv7-silentdragonlite-cli-v$APP_VERSION
cp target/armv7-unknown-linux-gnueabihf/release/silentdragonlite-cli target/Armv7-silentdragonlite-cli-v$APP_VERSION/
gpg --batch --output target/Armv7-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.sig --detach-sig target/Armv7-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli
cd target
cd Armv7-silentdragonlite-cli-v$APP_VERSION
gsha256sum silentdragonlite-cli > sha256sum.txt
cd ..
zip -r Armv7-silentdragonlite-cli-v$APP_VERSION.zip Armv7-silentdragonlite-cli-v$APP_VERSION 
cd ..


#AARCH64
rm -rf target/aarch64-silentdragonlite-cli-v$APP_VERSION
mkdir -p target/aarch64-silentdragonlite-cli-v$APP_VERSION
cp target/aarch64-unknown-linux-gnu/release/silentdragonlite-cli target/aarch64-silentdragonlite-cli-v$APP_VERSION/
gpg --batch --output target/aarch64-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli.sig --detach-sig target/aarch64-silentdragonlite-cli-v$APP_VERSION/silentdragonlite-cli
cd target
cd aarch64-silentdragonlite-cli-v$APP_VERSION
gsha256sum silentdragonlite-cli > sha256sum.txt
cd ..
zip -r aarch64-silentdragonlite-cli-v$APP_VERSION.zip aarch64-silentdragonlite-cli-v$APP_VERSION 
cd ..
