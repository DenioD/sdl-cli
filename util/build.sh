#!/usr/bin/env bash
# Copyright 2021-2022 The Hush Developers
# Distributed under the GPLv3 software license, see the accompanying
# file LICENSE or https://www.gnu.org/licenses/gpl-3.0.en.html

# Purpose: Script to build Hush silentdragonlite on x86 64-bit arch
## Usage: ./util/build.sh

# Check if rustc is installed on system and exits if it is not
if ! [ -x "$(command -v rustc)" ]; then
  echo 'Error: rustc is not installed. Install it and try again.' >&2
  exit 1
fi
# Check if cargo is installed on system and exits if it is not
if ! [ -x "$(command -v cargo)" ]; then
  echo 'Error: cargo is not installed. Install it and try again.' >&2
  exit 1
fi
# Check if rustfmt is installed on system and exits if it is not
if ! [ -x "$(command -v rustfmt)" ]; then
  echo 'Error: rustfmt is not installed. Install it and try again.' >&2
  exit 1
fi

echo ""
echo "Welcome to the Hush magic folks..."
echo ""
echo " ####  #####  #             ####  #      #    #####  #    # # #      #####     ##### # #    # ###### "
echo "#      #    # #            #    # #      #    #    # #    # # #      #    #      #   # ##  ## #      "
echo " ####  #    # #      ##### #      #      #    #####  #    # # #      #    #      #   # # ## # #####  "
echo "     # #    # #            #      #      #    #    # #    # # #      #    #      #   # #    # #      "
echo "#    # #    # #            #    # #      #    #    # #    # # #      #    #      #   # #    # #      "
echo " ####  #####  ######        ####  ###### #    #####   ####  # ###### #####       #   # #    # ###### "

# now to compiling...
echo ""
echo "You have the requirements installed, so let's build!"

cargo build --release

# check if compile was success
if [ $? -ne 0 ]; then
  echo ""
  echo 'Error: Something went wrong and it did not build successfully... Please reach out if you need support.' >&2
  exit 1
fi

echo ""
echo "Hush silentdragonlite-cli is now compiled for you. Enjoy and reach out if you need support."
echo "For options, run ./silentdragonlite --help"
