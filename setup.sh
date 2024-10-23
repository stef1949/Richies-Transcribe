#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Name of the conda environment
ENV_NAME="discordbot"
SERVICE_NAME="discord_bot.service"
SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"

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
pip install -r requirements.txt

# Prompt user for environment variables
read -p "Enter your Discord bot token: " BOT_TOKEN # Add other required prompts as needed

# Create .env file with the provided variables
echo "Creating .env file..."
echo "BOT_TOKEN=$BOT_TOKEN" > .env # Add other required variables if needed

echo ".env file created with the provided environment variables."

# Get the absolute path of the script to use in the service file
SCRIPT_PATH=$(readlink -f "$0")

# Create the systemd service unit file
echo "Creating systemd service unit file..."
sudo bash -c "cat > $SERVICE_PATH" <<EOL
[Unit]
Description=Discord Bot Service
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=5
User=$(whoami)
WorkingDirectory=$(dirname "$SCRIPT_PATH")
ExecStart=$(which conda) run -n $ENV_NAME python3 $(dirname "$SCRIPT_PATH")/bot.py
EnvironmentFile=$(dirname "$SCRIPT_PATH")/.env

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to apply the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable $SERVICE_NAME

# Start the service
sudo systemctl start $SERVICE_NAME

# Instructions to create .env file
echo "Systemd service '$SERVICE_NAME' created and started."
echo "Conda environment '$ENV_NAME' created and dependencies installed."
echo "Activate the environment with: conda activate $ENV_NAME"
