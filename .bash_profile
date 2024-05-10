#!/bin/bash

# Greet the user
echo "Hello $USER"

# Define environment variable COURSE_ID
export COURSE_ID="DevOpsFursa"

# Check permissions of .token file
if [ -e ~/.token ]; then
    token_perms=$(stat -c "%a" ~/.token)
    if [ "$token_perms" != "600" ]; then
        echo "Warning: .token file has too open permissions"
    fi
fi

# Change umask
umask 0007

# Add usercommands directory to PATH
export PATH="$PATH:/home/$USER/usercommands"

# Print current date in ISO 8601 format
date -u +"%Y-%m-%dT%H:%M:%S%:z"

# Define command alias for ltxt
alias ltxt='ls *.txt'

# Create or clean ~/tmp directory
if [ -d ~/tmp ]; then
    rm -rf ~/tmp/*
else
    mkdir ~/tmp
fi

# Kill process bound to port 8080 if exists
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
    kill $(lsof -t -i:8080)
fi
