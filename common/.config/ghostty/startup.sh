#!/bin/bash

DIR="${1:-$HOME}"
SESSION="${2:-dev}"

# Check if the session already exists
tmux has-session -t "$SESSION" 2>/dev/null

if [ $? -eq 0 ]; then
    tmux attach-session -t "$SESSION"
else
    tmux new-session -d -s "$SESSION" -n nvim -c "$DIR" -- nvim
    tmux new-window -t "$SESSION":1 -n fish -c "$DIR" -d
    tmux new-window -t "$SESSION":2 -n git  -c "$DIR" -d
    tmux attach-session -t "$SESSION"
fi
