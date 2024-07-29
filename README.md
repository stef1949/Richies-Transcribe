<p align="center">
  <a href="https://github.com/m-bain/whisperX/stargazers">
    <img src="https://img.shields.io/github/stars/m-bain/whisperX.svg?colorA=orange&colorB=orange&logo=github"
         alt="GitHub stars">
  </a>
  <a href="https://github.com/m-bain/whisperX/issues">
        <img src="https://img.shields.io/github/issues/m-bain/whisperx.svg"
             alt="GitHub issues">
  </a>
  <a href="https://github.com/m-bain/whisperX/blob/master/LICENSE">
        <img src="https://img.shields.io/github/license/m-bain/whisperX.svg"
             alt="GitHub license">
  </a>
  <a href="https://arxiv.org/abs/2303.00747">
        <img src="http://img.shields.io/badge/Arxiv-2303.00747-B31B1B.svg"
             alt="ArXiv paper">
  </a>
  <a href="https://twitter.com/intent/tweet?text=&url=https%3A%2F%2Fgithub.com%2Fm-bain%2FwhisperX">
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
git clone https://github.com/stef1949/discord-voice-transcription-bot.git
cd discord-voice-transcription-bot
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

## Configuration
### 1. Create a Discord Bot
- Go to the Discord Developer Portal.
- Create a new application.
- Go to the "Bot" tab and click "Add Bot".
- Copy the bot token.

### 2. Create a '.env' File
Create a .env file in the root directory of the project and add your Discord bot token:
```env
DISCORD_BOT_TOKEN=your_discord_bot_token_here
```
## Usage
### 1. Activate the Virtual Environment
On Unix-based systems:
```bash
source myenv/bin/activate
```
On Windows systems:
```bash
call myenv\Scripts\activate
```

### 2. Run the Bot
```bash
python bot.py
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License.
