#!/usr/bin/env bash

autorandr -c

# Delayed run. Start some tools. Basically works as autostart without clicking and desktop files.
if [ -x ~/.xsession_postponed ]; then
    (sleep 2 &&~/.xsession_postponed)&
fi

# Now start the real session script
exec "$@"
