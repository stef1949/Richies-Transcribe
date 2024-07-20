import os
import logging
import discord
from discord.ext import commands
import whisper
from pydub import AudioSegment
import asyncio
from concurrent.futures import ThreadPoolExecutor
from collections import defaultdict
from datetime import datetime, timedelta
import uuid

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Define intents
intents = discord.Intents.default()
intents.message_content = True

# Create bot instance with command prefix and intents
bot = commands.Bot(command_prefix='!', intents=intents)

# Load Whisper model
model = whisper.load_model("base.en")

# Create a ThreadPoolExecutor for parallel processing
executor = ThreadPoolExecutor()

# Rate limiting setup
user_message_timestamps = defaultdict(list)
RATE_LIMIT = 2  # Number of allowed messages
TIME_PERIOD = timedelta(seconds=10)  # Time period for rate limit (5 minutes)

def is_rate_limited(user_id):
    now = datetime.now()
    user_timestamps = user_message_timestamps[user_id]
    user_timestamps = [timestamp for timestamp in user_timestamps if now - timestamp < TIME_PERIOD]
    user_message_timestamps[user_id] = user_timestamps
    return len(user_timestamps) >= RATE_LIMIT

def update_rate_limit(user_id):
    now = datetime.now()
    user_message_timestamps[user_id].append(now)

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
            if attachment.content_type and attachment.content_type.startswith('audio/'):
                if is_rate_limited(message.author.id):
                    await message.reply("You are being rate limited. Please wait before sending another voice message.")
                    logging.info(f'Rate limit hit for user {message.author.id}')
                else:
                    await message.channel.send("Processing voice message...")
                    logging.info(f'Received voice message from {message.author}: {attachment.filename}')
                    update_rate_limit(message.author.id)
                    asyncio.create_task(process_voice_message(message, attachment))
    
    await bot.process_commands(message)

async def process_voice_message(message, attachment):
    try:
        audio_file_path = await download_file(attachment)
        wav_file_path = await convert_to_wav(audio_file_path)
        transcription = await transcribe_audio_with_whisper(wav_file_path)
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

async def download_file(attachment):
    unique_id = uuid.uuid4()
    file_extension = os.path.splitext(attachment.filename)[1]
    file_name = f"{unique_id}{file_extension}"
    file_path = f"./{file_name}"
    await attachment.save(file_path)
    logging.info(f'File downloaded: {file_path}')
    return file_path

async def convert_to_wav(audio_file_path):
    loop = asyncio.get_running_loop()
    wav_file_path = os.path.splitext(audio_file_path)[0] + '.wav'
    await loop.run_in_executor(executor, convert_audio, audio_file_path, wav_file_path)
    logging.info(f'Converted {audio_file_path} to {wav_file_path}')
    return wav_file_path

def convert_audio(audio_file_path, wav_file_path):
    audio = AudioSegment.from_file(audio_file_path)
    audio.export(wav_file_path, format='wav')

async def transcribe_audio_with_whisper(wav_file_path):
    loop = asyncio.get_running_loop()
    try:
        result = await loop.run_in_executor(executor, model.transcribe, wav_file_path)
        text = result['text']
        logging.info(f'Transcription successful: {text}')
        return text
    except Exception as e:
        logging.error(f"Transcription failed: {e}")
        return None

# Add your bot token here
bot.run(os.environ["BOT_TOKEN"])