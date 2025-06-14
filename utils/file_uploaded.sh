#!/bin/bash

#DIRECTORY_TO_WATCH="/Users/epham/PycharmProjects/dataproject/data"
PYTHON_SCRIPT="/Users/epham/PycharmProjects/dataproject/test.py"
#ADMIN_USER="adm"

# Install fswatch if not already installed. For macOS, we can use the fswatch command, which provides similar functionality to inotifywait
#if ! command -v fswatch &> /dev/null
#then
#    echo "fswatch could not be found, installing now..."
#    sudo chown -R "$ADMIN_USER" /usr/local/Homebrew /usr/local/etc/bash_completion.d /usr/local/share/doc /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks
#    brew install fswatch
#    chmod u+w /usr/local/Homebrew /usr/local/etc/bash_completion.d /usr/local/share/doc /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks
#fi

##make the file executable
#chmod +x file_monitor.sh

#touch "$DIRECTORY_TO_WATCH/.last_run"
python "$PYTHON_SCRIPT"

#fswatch -o "$DIRECTORY_TO_WATCH" | while read -r line
#do
#    # Check if there are new files in the directory
#    NEW_FILES=$(find "$DIRECTORY_TO_WATCH" -type f -newer "$DIRECTORY_TO_WATCH/.last_run")
#
#    if [ -n "$NEW_FILES" ]; then
#        echo "Nothing is happening"
#    else
#        echo "file added to directory"
#        python "$PYTHON_SCRIPT"
#        # Update the timestamp file to the current time
#        touch "$DIRECTORY_TO_WATCH/.last_run"
#        NEW_FILES="seed"
#    fi
#
#done