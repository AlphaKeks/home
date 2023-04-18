#!/usr/bin/env bash

cargo new $1
cd $1
echo "[package]" > Cargo.toml
echo "name = \"$1\"" >> Cargo.toml
echo "version = \"0.1.0\"" >> Cargo.toml
echo "authors = [\"AlphaKeks <alphakeks@dawn.sh\"]" >> Cargo.toml
echo "edition = \"2021\"" >> Cargo.toml
echo "description = \"\"" >> Cargo.toml
echo "documentation = \"https://github.com/AlphaKeks/$1/wiki\"" >> Cargo.toml
echo "readme = \"./README.md\"" >> Cargo.toml
echo "homepage = \"https://github.com/AlphaKeks/$1\"" >> Cargo.toml
echo "repository = \"https://github.com/AlphaKeks/$1\"" >> Cargo.toml
echo "license-file = \"./LICENSE\"" >> Cargo.toml
echo "" >> Cargo.toml
echo "[dependencies]" >> Cargo.toml
echo "color-eyre = \"0.6\"" >> Cargo.toml
echo "" >> Cargo.toml

# vim:filetype=bash
