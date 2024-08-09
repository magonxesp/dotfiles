#!/bin/bash

# Clean and recreate the bin directory
rm -rf bin/jre
rm -rf bin/*.jar
mkdir -p bin/jre/tmp

# Download JREs for every supported platform
wget -P bin/jre/tmp https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.4%2B7/OpenJDK21U-jre_x64_linux_hotspot_21.0.4_7.tar.gz
wget -P bin/jre/tmp https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.4%2B7/OpenJDK21U-jre_x64_mac_hotspot_21.0.4_7.tar.gz
wget -P bin/jre/tmp https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.4%2B7/OpenJDK21U-jre_aarch64_mac_hotspot_21.0.4_7.tar.gz

# Upack JREs

# Linux x64
mkdir bin/jre/tmp/linux_x64
tar -xvf bin/jre/tmp/OpenJDK21U-jre_x64_linux_hotspot_21.0.4_7.tar.gz --directory bin/jre/tmp/linux_x64
mv bin/jre/tmp/linux_x64/jdk-21.0.4+7-jre bin/jre/linux_x64

# macOS x64 (Intel)
mkdir bin/jre/tmp/macOS_x64
tar -xvf bin/jre/tmp/OpenJDK21U-jre_x64_mac_hotspot_21.0.4_7.tar.gz --directory bin/jre/tmp/macOS_x64
mv bin/jre/tmp/macOS_x64/jdk-21.0.4+7-jre bin/jre/macOS_x64

# macOS arm (apple silicon chips)
mkdir bin/jre/tmp/macOS_arm64
tar -xvf bin/jre/tmp/OpenJDK21U-jre_aarch64_mac_hotspot_21.0.4_7.tar.gz --directory bin/jre/tmp/macOS_arm64
mv bin/jre/tmp/macOS_arm64/jdk-21.0.4+7-jre bin/jre/macOS_arm64

# Clean temporal directory
rm -rf bin/jre/tmp

# Build the program
./gradlew build
cp cli/build/libs/cli-all.jar bin/dotfiles.jar
