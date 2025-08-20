# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A bash-based GitHub Actions monitoring system with desktop notifications. Provides two main scripts for monitoring GitHub workflow runs with real-time status updates and persistent notifications.

## Scripts Architecture

### Core Scripts
- **gh-monitor**: Single workflow run monitor with detailed status tracking (`gh-monitor:208-373`)
- **gh-monitor-my-jobs**: Auto-discovery monitor for user's running workflows (`gh-monitor-my-jobs:201-328`)
- **install.sh**: Symlink installer to `~/.local/bin` directory

### Key Components
- Status tracking with color-coded terminal output
- Desktop notifications via `notify-send` with HTML formatting
- Temp file management in `/tmp/gh-monitor-*` for process tracking
- Smart repository detection from git remotes
- User filtering to monitor only authenticated user's workflows

## Common Commands

### Installation
```bash
./install.sh
```

### Basic Usage
```bash
# Monitor specific workflow run
gh-monitor <run_id> --repo owner/repo --interval 10

# Auto-monitor user's jobs (from git repo directory)
gh-monitor-my-jobs --interval 10

# Specific repository monitoring
gh-monitor-my-jobs --repo owner/repo --quiet
```

### Testing
No formal test suite exists. Manual testing involves:
1. Triggering GitHub Actions in a test repository
2. Running monitors with various options
3. Verifying notifications and status updates

## Dependencies

**Required:**
- `gh` (GitHub CLI) - authenticated via `gh auth login`
- `jq` - JSON parsing
- `bash` - scripts are bash-specific

**Optional:**
- `notify-send` - desktop notifications
- `paplay`/`beep` - audio notifications
- Git repository for auto-detection

## Process Management

- Background processes use PID files in `/tmp/gh-monitor-{run_id}.pid`
- Waiting state tracking via `/tmp/gh-monitor-{run_id}-waiting` files
- Clean shutdown via trap handlers (`gh-monitor-my-jobs:325`)
- Auto-cleanup of finished monitor processes (`gh-monitor-my-jobs:188-199`)

## Key Functions

### Status Detection (`gh-monitor:91-100`)
- Fetches workflow status via GitHub API
- Supports both repository-specific and auto-detected contexts

### Notification System (`gh-monitor:37-88`)
- Multi-tier notifications: console, desktop, audio
- HTML formatting support for rich notifications
- Persistent notifications for critical events

### Repository Auto-detection (`gh-monitor-my-jobs:73-90`)
- Parses git remote origin for GitHub repository
- Supports both SSH and HTTPS remote formats
- Fallback to explicit `--repo` parameter

## Configuration Notes

- Default check interval: 10 seconds
- Default timeout: 60 minutes
- User filtering based on authenticated GitHub user
- Notification urgency levels: normal, critical, completion