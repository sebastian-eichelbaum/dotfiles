#!/usr/bin/env bash

# Done by the NixOS setup when starting X. Enable this on other systems.
autorandr --match-edid --change --default Mobile

# Delayed run. Start some tools. Basically works as autostart without clicking and desktop files.
if [ -x ~/.xsession_postponed ]; then
    (sleep 2 && ~/.xsession_postponed) &
fi

# Nautilus 47 crashing on Nvidia. This circumvents the problem for now
export GSK_RENDERER=cairo

#export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5

# Now start the real session script
exec "$@"
