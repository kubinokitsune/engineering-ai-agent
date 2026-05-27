# new-project.ps1
# Usage: .\scripts\new-project.ps1 -Name "f1-car-v2"
# Creates a new project folder and updates the README project table.

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    [string]$Description = "Engineering project"
)

$base = Split-Path $PSScriptRoot -Parent
$projectPath = "$base\projects\$Name"
$date = Get-Date -Format "yyyy-MM-dd"

if (Test-Path $projectPath) {
    Write-Host "Project '$Name' already exists at $projectPath"
    exit 1
}

# Create project folder structure
New-Item -ItemType Directory -Path "$projectPath" | Out-Null
New-Item -ItemType Directory -Path "$projectPath\build-logs" | Out-Null
New-Item -ItemType Directory -Path "$projectPath\cad" | Out-Null
New-Item -ItemType Directory -Path "$projectPath\testing" | Out-Null
New-Item -ItemType Directory -Path "$projectPath\research" | Out-Null

# Create project README
@"
# $Name

**Created:** $date
**Description:** $Description

## Overview

<!-- Add project description here -->

## Build Log

| Date | Session | Notes |
|------|---------|-------|

## Test Results

| Date | Test | Result | Notes |
|------|------|--------|-------|

## Key Decisions

<!-- Document major design decisions here -->

## Links

<!-- CAD files, references, etc. -->
"@ | Out-File "$projectPath\README.md" -Encoding utf8

# Create first build log
@"
# Build Log — $date

**Project:** $Name
**Session:** 1

## What I worked on

## Decisions made

## Next steps

## AI queries used

"@ | Out-File "$projectPath\build-logs\$date-session-1.md" -Encoding utf8

# Update root README project table
$readmePath = "$base\README.md"
$readmeContent = Get-Content $readmePath -Raw
$newRow = "| [$Name](projects/$Name/README.md) | Active | $date |"
$readmeContent = $readmeContent -replace "(\| Project \| Status \| Last Updated \|\r?\n\|[-|]+\|\r?\n)", "`$1$newRow`n"
$readmeContent | Out-File $readmePath -Encoding utf8 -NoNewline

Write-Host "Project '$Name' created at $projectPath"
Write-Host "README updated."
