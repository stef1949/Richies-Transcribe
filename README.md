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
