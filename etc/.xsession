#!/usr/bin/env bash

# Delayed run. Start some tools. Basically works as autostart without clicking and desktop files.
if [ -x ~/.xsession_postponed ]; then
    (sleep 2 &&~/.xsession_postponed)&
fi

# xmessage "$@"
# Now start the real session script
exec "$@"
