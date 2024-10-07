#!/usr/bin/env bash

# Done by the NixOS setup when starting X. Enable this on other systems.
autorandr --match-edid --change --default Mobile

# Delayed run. Start some tools. Basically works as autostart without clicking and desktop files.
if [ -x ~/.xsession_postponed ]; then
    (sleep 2 && ~/.xsession_postponed) &
fi

# Now start the real session script
exec "$@"
