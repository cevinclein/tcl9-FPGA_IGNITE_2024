#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <tcl_version>"
  echo "Options: tcl8 | tcl9"
  exit 1
fi

# Execute commands based on the argument
if [ "$1" == "tcl8" ]; then
  echo "Pulling prebuilt image for tcl8..."
  docker pull efabless/openlane:2023.07.19-1
elif [ "$1" == "tcl9" ]; then
  echo "Building image locally for tcl9..."
  docker pull efabless/openlane:2023.07.19-1
  docker build -t efabless/openlane:2023.07.19-1 -f Dockerfile .
elif [ "$1" == "tcl9-latimg" ]; then
  echo "Building image locally for tcl9 with openlane latest tag..."
  docker pull efabless/openlane:2023.07.19-1
  docker build -t efabless/openlane:2023.07.19-1 -f Dockerfile.nix .
elif [ "$1" == "tcl-vers" ]; then
  echo 'puts [info patchlevel]' | docker run --rm -i efabless/openlane:2023.07.19-1 tclsh
else
  echo "Invalid option: $1"
  echo "Options: tcl8 | tcl9"
  exit 1
fi
