# GitHub Monitor

Scripts for monitoring GitHub Actions workflow runs with desktop notifications.

## Scripts

### gh-monitor

Monitors a specific GitHub Actions run and notifies when it completes.

```bash
gh-monitor <run_id> [options]

Options:
  -r, --repo REPO     Repository (owner/repo format)
  -i, --interval SEC  Check interval in seconds (default: 30)
  -t, --timeout MIN   Timeout in minutes (default: 60)
  -q, --quiet         Quiet mode - only final notification
  -h, --help          Show help

Examples:
  gh-monitor 16649567114
  gh-monitor 16649567114 --repo KosikGroup/web-frontend
  gh-monitor 16649567114 --interval 10 --quiet
```

### gh-monitor-my-jobs

Automatically monitors running workflow runs for the current user and spawns gh-monitor for each new job.

**🎯 Smart Repository Detection:**

- When run from a git repository, automatically detects the GitHub repo from `git remote`
- Only monitors jobs triggered by the current user (`jasir`)
- Can be explicitly overridden with `--repo` option

```bash
gh-monitor-my-jobs [options]

Options:
  -i, --interval SEC  Check interval in seconds (default: 30)
  -r, --repo REPO     Repository to monitor (owner/repo format)
                      If not specified, auto-detects from current git repo
  -q, --quiet         Quiet mode
  -h, --help          Show help

Examples:
  # Auto-detect repo from current directory
  cd ~/my-project && gh-monitor-my-jobs

  # Monitor specific repository
  gh-monitor-my-jobs --repo KosikGroup/web-frontend

  # Quick monitoring with custom interval
  gh-monitor-my-jobs --interval 15 --quiet
```

**💡 Usage Tips:**

- Run from your project directory for automatic repo detection
- Only finds jobs you personally triggered (filtered by GitHub username)
- Great for monitoring CI/CD pipelines while working on features

## Features

- 🔔 **Desktop notifications** with persistent critical alerts
- 📊 **Real-time job status** with current running steps
- ⏸️ **Waiting state detection** for approval workflows
- 🎯 **Automatic monitoring** of new workflow runs
- 🚦 **Color-coded status** output
- 🔄 **Auto-cleanup** of finished monitors

## Installation

```bash
git clone https://github.com/jasir/gh-monitor.git
cd gh-monitor
./install.sh
```

## Requirements

- **GitHub CLI (`gh`)** - must be authenticated (`gh auth login`)
- **`jq`** for JSON parsing
- **`notify-send`** for desktop notifications (optional)
- **Git repository** (for auto-detection) or explicit `--repo` parameter

## Usage Notes

- **Auto-detection**: `gh-monitor-my-jobs` automatically detects GitHub repo from `git remote origin`
- **User filtering**: Only monitors jobs triggered by the authenticated GitHub user
- **Persistent notifications** require manual dismissal for critical events
- **Temp files** in `/tmp/gh-monitor-*` track running monitors
- **Clean shutdown**: Ctrl+C cleanly shuts down all child processes

## Quick Start

```bash
# Clone and install
git clone https://github.com/jasir/gh-monitor.git
cd gh-monitor
./install.sh

# Monitor your current project
cd ~/my-project
gh-monitor-my-jobs

# Monitor specific repository
gh-monitor-my-jobs --repo owner/repo-name
```
