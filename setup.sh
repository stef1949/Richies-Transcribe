#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Create virtual environment
python3 -m venv myenv

# Activate virtual environment
source myenv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install required packages
pip install discord.py requests pydub torch python-dotenv
pip install git+https://github.com/openai/whisper.git

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
echo "Please create a .env file in the project root directory with the following content:"
echo "DISCORD_BOT_TOKEN=your_discord_bot_token_here"

echo "Setup complete. Activate your virtual environment using 'source myenv/bin/activate' and run the bot using 'python bot.py'."
