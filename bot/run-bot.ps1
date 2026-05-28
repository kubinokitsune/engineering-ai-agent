# run-bot.ps1 — start the Engineering AI Discord bot
# Run from the engineering-ai-agent directory: .\bot\run-bot.ps1

$botDir = $PSScriptRoot
$envFile = Join-Path $botDir "..\env"

Write-Host "Starting Engineering AI bot..."
python "$botDir\bot.py"
