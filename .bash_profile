#!/bin/bash

# Greet the user
echo "Hello $USER"

# Define environment variable COURSE_ID
export COURSE_ID="DevOpsFursa"

# Check permissions of .token file
if [ -e ~/.token ]; then
    token_perms=$(stat -c "%a" ~/.token) # Retrieve the permissions of the .token file
    if [ "$token_perms" != "600" ]; then # If permissions are not set to 600 (read and write by the user only), display a warning
        echo "Warning: .token file has too open permissions"
    fi
fi

# Change umask
umask 0006

# Add usercommands directory to PATH
export PATH="$PATH:/home/$USER/usercommands"

# Print current date in ISO 8601 format
date -u +"%Y-%m-%dT%H:%M:%S%:z"

# Define command alias for ltxt
alias ltxt='ls *.txt'

# Create or clean ~/tmp directory
if [ -d ~/tmp ]; then
    rm -rf ~/tmp/*
else # if ~/tmp does not exists
    mkdir ~/tmp
fi

# Kill process bound to port 8080 if it exists
# Check if any process is listening on port 8080 using lsof
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
    kill $(lsof -t -i:8080) # If a process is found, kill it using its PID
fi
