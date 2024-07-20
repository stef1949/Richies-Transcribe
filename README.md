# Richies-Transcribe, a Discord Voice Message Transcription Bot

```markdown
# Discord Voice Message Transcription Bot

This Discord bot uses OpenAI's Whisper model to transcribe voice messages into English text. The bot listens for voice messages in Discord channels and replies with the transcribed text.

## Features

- Listens for voice messages in Discord channels.
- Transcribes voice messages to English text using the Whisper model.
- Replies to the original message with the transcribed text.

## Prerequisites

- Python 3.7+
- Discord account and server
- `ffmpeg` installed on your system

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/discord-voice-transcription-bot.git
   cd discord-voice-transcription-bot
   ```

2. **Set Up Virtual Environment**

   ```bash
   python -m venv myenv
   source myenv/bin/activate  # On Windows: myenv\Scripts\activate
   ```

3. **Install Dependencies**

   ```bash
   pip install discord.py requests pydub torch
   pip install git+https://github.com/openai/whisper.git@main  # Replace 'main' with the specific commit or tag if known
   ```

4. **Install `ffmpeg`**

   - **Windows**: Download `ffmpeg` from [FFmpeg](https://ffmpeg.org/download.html) and add it to your system PATH.
   - **macOS**: Install using Homebrew:
     ```bash
     brew install ffmpeg
     ```
   - **Linux**: Install using your package manager. For example, on Ubuntu:
     ```bash
     sudo apt-get install ffmpeg
     ```

## Configuration

1. **Create a Discord Bot**

   - Go to the [Discord Developer Portal](https://discord.com/developers/applications).
   - Create a new application.
   - Go to the "Bot" tab and click "Add Bot".
   - Copy the bot token.

2. **Update the Bot Token**

   - In the `bot.py` script, replace `YOUR_DISCORD_BOT_TOKEN` with your actual bot token.

## Usage

1. **Run the Bot**

   ```bash
   python bot.py
   ```

2. **Test the Bot**

   - Invite the bot to your Discord server using the OAuth2 URL.
   - In your Discord server, type `!ping` to test if the bot is responsive. The bot should reply with "Pong!".
   - Send a voice message in the text channel. The bot should process the voice message, transcribe it using Whisper, and reply to the original message with the transcription.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License.
```
