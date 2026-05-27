# sync-project.ps1
# Usage: .\scripts\sync-project.ps1 -Project "f1-car-v2"
# Adds a new build log entry and commits + pushes the repo.

param(
    [Parameter(Mandatory=$true)]
    [string]$Project,
    [string]$Notes = ""
)

$base = Split-Path $PSScriptRoot -Parent
$projectPath = "$base\projects\$Project"
$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HHmm"

if (-not (Test-Path $projectPath)) {
    Write-Host "Project '$Project' not found. Run new-project.ps1 first."
    exit 1
}

# Count existing sessions today
$todaySessions = (Get-ChildItem "$projectPath\build-logs" -Filter "$date-*.md" -ErrorAction SilentlyContinue).Count
$sessionNum = $todaySessions + 1

$logFile = "$projectPath\build-logs\$date-session-$sessionNum.md"

@"
# Build Log — $date (Session $sessionNum)

**Project:** $Project
**Time:** $time

## What I worked on

$Notes

## Decisions made

## Next steps

## AI queries used

"@ | Out-File $logFile -Encoding utf8

Write-Host "Build log created: $logFile"

# Git commit and push
Set-Location $base
git add -A
git commit -m "sync: $Project build log $date session $sessionNum"
git push origin master

Write-Host "Synced to GitHub."
