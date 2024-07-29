#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Name of the conda environment
ENV_NAME="discordbot"

# Check if Conda is installed
if ! command -v conda &>/dev/null; then
    echo "Conda is not installed. Please install Conda and try again."
    exit 1
fi

# Check if ffmpeg is installed, if not install it based on OS type
if ! command_exists ffmpeg ; then
    echo "ffmpeg is not installed. Installing ffmpeg..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y ffmpeg
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command_exists brew ; then
            echo "Homebrew is not installed. Please install Homebrew and try again."
            exit 1
        fi
        brew install ffmpeg
    else
        echo "Unsupported OS type: $OSTYPE"
        exit 1
    fi
else
    echo "ffmpeg is already installed."
fi

# Create a new conda environment with Python
if conda info --envs | grep -q "^$ENV_NAME\s" ; then
    echo "Conda environment '$ENV_NAME' already exists. Skipping environment creation."
else
    echo "Creating conda environment '$ENV_NAME' with Python..."
    conda create -n $ENV_NAME python -y
fi

# Activate virtual environment
echo "Activating conda environment '$ENV_NAME'..."
source activate $ENV_NAME

# Upgrade pip
pip install --upgrade pip

# Install required packages
echo "Installing Python dependencies..."
pip install requirements.txt

# Install ffmpeg
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update
    sudo apt-get install -y ffmpeg
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Please install Homebrew and try again."
        exit 1
    fi
    brew install ffmpeg
fi

# Instructions to create .env file
echo "Conda environment '$ENV_NAME' created and dependencies installed."
echo "Activate the environment with: conda activate $ENV_NAME"
