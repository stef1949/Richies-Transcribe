@echo off
setlocal

:: Check if Python is installed
where /q python
if errorlevel 1 (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)

:: Create virtual environment
python -m venv myenv

:: Activate virtual environment
call myenv\Scripts\activate

:: Upgrade pip
pip install --upgrade pip

:: Install required packages
pip install discord.py requests pydub torch python-dotenv
pip install git+https://github.com/openai/whisper.git

:: Install ffmpeg
powershell -Command "Invoke-WebRequest -Uri https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip -OutFile ffmpeg-release-essentials.zip"
powershell -Command "Expand-Archive -Force ffmpeg-release-essentials.zip -DestinationPath ."
set PATH=%cd%\ffmpeg-release-essentials\bin;%PATH%

:: Instructions to create .env file
echo Please create a .env file in the project root directory with the following content:
echo DISCORD_BOT_TOKEN=your_discord_bot_token_here

echo Setup complete. Activate your virtual environment using "call myenv\Scripts\activate" and run the bot using "python bot.py".

endlocal
pause
