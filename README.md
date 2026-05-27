# Engineering AI Agent

Local AI assistant for engineering projects — F1 in Schools, fabrication, CAD, and more.

**Stack:** Ollama (llama3.1:8b) · OpenWebUI · n8n · Discord Bot

## Architecture

```
Discord → n8n Workflow → Ollama (local AI) → Discord Reply
```

## Directory Structure

```
engineering-ai-agent/
├── projects/        # One folder per project with logs and summaries
├── build-logs/      # Dated build session notes
├── research/        # Material specs, aerodynamics, references
├── testing/         # Test results and data
├── cad/             # CAD notes, screenshots, export references
├── ideas/           # Brainstorm notes and concepts
├── workflows/
│   ├── n8n/         # Exported n8n workflow JSON files
│   └── discord/     # Discord bot config and command docs
├── memory/          # AI context files fed into prompts
└── scripts/         # Automation scripts
```

## Quick Start

1. Ensure Ollama is running: `ollama serve`
2. Open OpenWebUI: http://localhost:3000
3. Start n8n and load workflow from `workflows/n8n/`
4. Message Discord bot to test

## Projects

<!-- Projects auto-populate here via new-project.ps1 -->

| Project | Status | Last Updated |
|---------|--------|-------------|

## Setup Status

- [x] Ollama installed + llama3.1:8b downloaded
- [x] Docker installed
- [x] OpenWebUI running (localhost:3000)
- [ ] n8n installed
- [ ] Discord bot created
- [ ] n8n workflow connected
