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
Automatically monitors all running workflow runs and spawns gh-monitor for each new job.

```bash
gh-monitor-my-jobs [options]

Options:
  -i, --interval SEC  Check interval in seconds (default: 30)
  -r, --repo REPO     Repository to monitor (default: all accessible)
  -q, --quiet         Quiet mode
  -h, --help          Show help

Examples:
  gh-monitor-my-jobs
  gh-monitor-my-jobs --repo KosikGroup/web-frontend --interval 15
```

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

- GitHub CLI (`gh`) - authenticated
- `jq` for JSON parsing
- `notify-send` for desktop notifications (optional)

## Usage Notes

- Persistent notifications require manual dismissal for critical events
- Temp files in `/tmp/gh-monitor-*` track running monitors
- Ctrl+C cleanly shuts down all child processes