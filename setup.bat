@echo off
setlocal

REM Name of the conda environment
set ENV_NAME=discord-bot-env

REM Check if conda is installed
where conda >nul 2>&1
if errorlevel 1 (
    echo Conda is not installed. Please install Conda and try again.
    exit /b 1
)

REM Check if Python is installed
where python >nul 2>&1
if errorlevel 1 (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)

REM Create the conda environment with Python 3.8
conda env list | findstr /C:"%ENV_NAME%" >nul 2>&1
if errorlevel 1 (
    echo Creating conda environment %ENV_NAME% with Python 3.8...
    conda create -n %ENV_NAME% python=3.8 -y
) else (
    echo Conda environment %ENV_NAME% already exists. Skipping environment creation.
)

REM Activate the environment and install dependencies
echo Activating conda environment %ENV_NAME%...
call conda activate %ENV_NAME%

echo Installing Python dependencies...
pip install discord.py==1.7.3 whisperx==1.0.0 pydub==0.25.1 python-dotenv==0.21.0

REM Prompt user for environment variables
set /p BOT_TOKEN=Enter your Discord bot token: 
set /p OTHER_VAR=Enter other required variables: 

REM Create .env file with the provided variables
echo Creating .env file...
(
    echo BOT_TOKEN=%BOT_TOKEN%
    echo OTHER_VAR=%OTHER_VAR%
) > .env

echo .env file created with the provided environment variables.

REM Get the absolute path of the script to use in the service file
for %%I in ("%~f0") do set SCRIPT_PATH=%%~dpI

REM Create the Windows service
echo Creating Windows service...

REM Define the service name and display name
set SERVICE_NAME=DiscordBotService
set DISPLAY_NAME=Discord Bot Service

REM Define the service description
set SERVICE_DESCRIPTION="Discord Bot Service"

REM Define the path to the conda activate script and the bot script
set CONDA_PATH=%SCRIPT_PATH%..\..\Scripts\activate
set BOT_SCRIPT=%SCRIPT_PATH%your_script.py

REM Create the service
sc create %SERVICE_NAME% binPath= "cmd /c call %CONDA_PATH% %ENV_NAME% ^&^& python %BOT_SCRIPT%" start= auto DisplayName= "%DISPLAY_NAME%"
sc description %SERVICE_NAME% %SERVICE_DESCRIPTION%

REM Start the service
sc start %SERVICE_NAME%

echo Windows service %SERVICE_NAME% created and started.
echo Conda environment %ENV_NAME% created and dependencies installed.
echo Activate the environment with: call conda activate %ENV_NAME%

endlocal
