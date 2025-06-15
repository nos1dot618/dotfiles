#!/usr/bin/env bash
set -xeu

sudo apt-get -y install git tmux fish

# Python related packages
sudo apt-get -y install python3.11-venv

# CXX related packages
sudo apt-get -y install clangd cmake clang libstdc++-12-dev
