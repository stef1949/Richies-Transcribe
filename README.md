<p align="center">
  <a href="https://github.com/stef1949/Richies-Transcribe/">
    <img src="https://img.shields.io/github/stars/stef1949/Richies-Transcribe.svg?colorA=orange&colorB=orange&logo=github"
         alt="GitHub stars">
  </a>
  <a href="https://github.com/stef1949/Richies-Transcribe/issues">
        <img src="https://img.shields.io/github/issues/stef1949/Richies-Transcribe.svg"
             alt="GitHub issues">
  </a>
  <a href="https://github.com/stef1949/Richies-Transcribe/blob/main/LICENSE">
        <img src="https://img.shields.io/github/license/stef1949/Richies-Transcribe.svg"
             alt="GitHub license">
  </a>
  <a href="https://twitter.com/intent/tweet?text=&url=https://github.com/stef1949/Richies-Transcribe/">
  <img src="https://img.shields.io/twitter/url/https/github.com/m-bain/whisperX.svg?style=social" alt="Twitter">
  </a>      
</p>

<h1 align="center">
    <picture>
        <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/d11efd99-233f-4a39-b6fa-15f51c8e5a1b">
        <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/d11efd99-233f-4a39-b6fa-15f51c8e5a1b">
        <img src="https://github.com/user-attachments/assets/d11efd99-233f-4a39-b6fa-15f51c8e5a1b" alt="Dependabot" width="336">
    </picture>
</h1>


# Discord Voice Message Transcription Bot

This Discord bot uses OpenAI's Whisper model to transcribe voice messages into English text. The bot listens for voice messages in Discord channels and replies with the transcribed text.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features

- Listens for voice messages in Discord channels.
- Transcribes voice messages to English text using the Whisper model.
- Replies to the original message with the transcribed text.

## Prerequisites

- Python 3.7+
- Discord account and server
- `ffmpeg` installed on your system

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/stef1949/Richies-Transcribe.git
cd Richies-Transcribe
```
### 2. Run the Setup Script
   For Unix-based systems (Linux and macOS):
```bash
chmod +x setup.sh
./setup.sh
```
   For Windows systems:
```bash
setup.bat
```

## Manual Configuration
### 1. Create a Discord Bot
- Go to the Discord Developer Portal.
- Create a new application.
- Go to the "Bot" tab and click "Add Bot".
- Copy the bot token.

### 2. Create a '.env' File
Create a .env file in the root directory of the project and add your Discord bot token:
```env
BOT_TOKEN=your_discord_bot_token_here
```
## Usage
### 1. Create Virtual Environment
On Unix-based systems:
```bash
conda create -n discordbot python -y
```
On Windows systems:
```bash
conda create -n discordbot python -y
```

### 2. Activate the Virtual Environment
On Unix-based systems:
```bash
source activate discordbot
```
On Windows systems:
```bash
conda activate discordbot
```

### 3. Run the Bot
```bash
python bot.py
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Acknowledgements

We would like to express our gratitude to the following individuals, libraries, and resources that have made this project possible:

### Libraries and Tools
- **discord.py**: An essential library for interacting with the Discord API. Without this robust library, the development of this bot would not have been possible.
- **whisperx**: For providing the speech recognition model used in the bot to transcribe audio messages.
- **pydub**: A fantastic library for audio processing, enabling seamless conversion and handling of audio files within the bot.
- **python-dotenv**: For simplifying the management of environment variables in the project.

### Platforms
- **Conda**: For providing a powerful package management and environment management system that made handling dependencies straightforward and efficient.

### Open Source Community
We extend our sincere thanks to the open-source community for their continuous contributions to libraries and tools that make projects like this possible.

### Inspiration and Support
- **GitHub**: For offering a collaborative platform for code sharing and project management.

Thank you all for your support and contributions!

## License
This project is licensed under the MIT License.
