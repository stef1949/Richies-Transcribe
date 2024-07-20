# Richies-Transcribe, a Discord Voice Message Transcription Bot

### README.md

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

## Bot Script

```python
import os
import logging
import discord
from discord.ext import commands
import whisper
from pydub import AudioSegment

# Set up logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# Define intents
intents = discord.Intents.default()
intents.message_content = True

# Create bot instance with command prefix and intents
bot = commands.Bot(command_prefix='!', intents=intents)

# Load Whisper model (explicitly specifying 'base' model)
try:
    model = whisper.load_model("base")  # Using 'base', change as needed for 'tiny', 'small', etc.
    logging.info("Whisper 'base' model loaded successfully.")
except Exception as e:
    logging.error(f"Failed to load Whisper model: {e}")

# Event handler for when the bot is ready
@bot.event
async def on_ready():
    logging.info(f'Bot is ready. Logged in as {bot.user}')

# Ping command to test if the bot is responding
@bot.command()
async def ping(ctx):
    await ctx.send('Pong!')
    logging.info('Ping command received and Pong sent')

# Event handler for when a message is sent
@bot.event
async def on_message(message):
    if message.author == bot.user:
        return
    
    # Check if the message has voice message attachments
    if message.attachments:
        for attachment in message.attachments:
            if attachment.content_type.startswith('audio/'):
                await message.channel.send("Processing voice message...")
                logging.info(f'Received voice message from {message.author}: {attachment.filename}')
                try:
                    audio_file_path = await download_file(attachment)
                    wav_file_path = convert_to_wav(audio_file_path)
                    transcription = transcribe_audio_with_whisper(wav_file_path)
                    if transcription:
                        await message.reply(f'Transcription: {transcription}')
                        logging.info(f'Transcription sent for {attachment.filename}')
                    else:
                        await message.reply("Sorry, I couldn't transcribe the audio.")
                        logging.warning(f'Failed to transcribe {attachment.filename}')
                except Exception as e:
                    logging.error(f'Error processing {attachment.filename}: {e}')
                finally:
                    # Clean up the downloaded and converted files
                    if os.path.exists(audio_file_path):
                        os.remove(audio_file_path)
                        logging.info(f'Deleted temporary file {audio_file_path}')
                    if os.path.exists(wav_file_path):
                        os.remove(wav_file_path)
                        logging.info(f'Deleted temporary file {wav_file_path}')
    
    await bot.process_commands(message)

async def download_file(attachment):
    try:
        file_name = attachment.filename
        file_path = f"./{file_name}"
        await attachment.save(file_path)
        logging.info(f'File downloaded: {file_path}')
        return file_path
    except Exception as e:
        logging.error(f"Failed to download file: {e}")
        raise

def convert_to_wav(audio_file_path):
    try:
        wav_file_path = os.path.splitext(audio_file_path)[0] + '.wav'
        audio = AudioSegment.from_file(audio_file_path)
        audio.export(wav_file_path, format='wav')
        logging.info(f'Converted {audio_file_path} to {wav_file_path}')
        return wav_file_path
    except Exception as e:
        logging.error(f"Failed to convert to WAV: {e}")
        raise

def transcribe_audio_with_whisper(wav_file_path):
    try:
        result = model.transcribe(wav_file_path, language='en')
        text = result['text']
        logging.info(f'Transcription successful: {text}')
        return text
    except Exception as e:
        logging.error(f"Transcription failed: {e}")
        return None

# Add your bot token here
bot.run('YOUR_DISCORD_BOT_TOKEN')
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License.
```
