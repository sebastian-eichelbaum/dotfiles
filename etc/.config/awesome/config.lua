---------------------------------------------------------------------------------------------------
--
-- ░█░█░█▀▀░█▀▀░█▀▄░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
-- ░█░█░▀▀█░█▀▀░█▀▄░░░█░░░█░█░█░█░█▀▀░░█░░█░█
-- ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
--
-- Provide the user specific app preferences and options.
---------------------------------------------------------------------------------------------------

local awful = require("awful")

local home = os.getenv("HOME")
local bin = home .. '/.dotfiles/bin/'

-- The modkey to use. Mod4 is the "windows" key
local modkey = "Mod4"

-- {{{ Client properties
local clients = {
    -- Client default properties. Used if not explicitly overwritten.
    properties = {
        focus     = awful.client.focus.filter,
        raise     = true,
        screen    = awful.screen.preferred,

        -- Default placement, especially for floating windows
        placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered,

        -- Respect size requests by clients? This can cause gaps between tiled windows if a window requests
        -- a smaller size. Terminals for example request sizes that match multiples of their char-sizes.
        size_hints_honor = false,

        -- In general, enable titlebars for all clients?
        titlebars_enabled = false,

        -- Transient clients can be centered in its parent. This en-/disables it globally.
        disallow_autocenter = false
    },

    -- Floating client specific rules
    floating = {
        -- Use the titlebar ONLY for floating clients? If false and the above client property "titlebars_enabled" is true,
        -- titlebars are added to all windows.
        titlebar = false,
    }
}
-- }}}

-- {{{ Styling options
local style = {
    -- The default base-font for everything
    font = "Hack Nerd Font Bold 9",
    -- Some fonts use own font names for bold versions. Set it here.
    fontBold = "Hack Nerd Font Bold 9",
    -- If you use some specific font for your tag names, set it here. Set to nil to use the base font
    tagFont = "Font Awesome 6 Free Solid 11",

    -- Wallpaper. either a path or a function
    wallpaper = os.getenv( "HOME" ) .. "/.background-image",

    -- More options
    gap = 0,
    borderWidth = 1,

    -- Focus/Unfocus transparency
    focusOpacity = 1.0,
    unfocusOpacity = 1.0,
}
-- }}}

-- {{{ Tagging
local tagging = {
    -- Hide empty tags?
    hideEmpty = true,
    -- Unspecified screens use this default style. ID and name are ignored.
    default = {layout = awful.layout.suit.tile.bottom, master_count = 2, master_width_factor = 0.75},
    screens = {
        -- Screen 0
        {
            -- Options supported: see https://awesomewm.org/doc/api/classes/tag.html#Object_properties
            { ids = { "primary" },
                name = " ",
                -- icon = "/usr/local/share/awesome/icons/awesome32.png",
                layout = awful.layout.suit.tile.bottom,
                master_count = 2,
                master_width_factor = 0.75
            },
            { ids = { "secondary" },
                name = " ",
                layout = awful.layout.suit.tile.bottom,
                master_count = 2,
                master_width_factor = 0.75,
            },
            { ids = {},
                name = " ",
                layout = awful.layout.suit.tile.bottom,
                master_count = 2,
                master_width_factor = 0.75
            },
            { ids = {},
                name = " ",
                layout = awful.layout.suit.tile.bottom,
                master_count = 2,
                master_width_factor = 0.75
            },
            { ids = { "draw" },
                name = " ",
                layout = awful.layout.suit.tile.bottom,
                master_count = 2,
                master_width_factor = 0.75
            },
            { ids = { "mail" },
                name = " ",
                layout = "cascadetile",
                master_count = 1,
                master_width_factor = 0.60,
            },
            { ids = { "www" },
                -- name = " ",
                -- name = " ",
                -- name = " ",
                name = " ",
                layout = awful.layout.suit.max
            },
            { ids = { "games", "guests" },
                name = " ",
                layout = awful.layout.suit.max.fullscreen
            },
            { ids = { "media" },
                name = " ",
                layout = awful.layout.suit.tile,
                master_count = 1,
                master_width_factor = 0.60
            },

        }
        -- Define more screens as needed in the same style as above.
        -- Other screens use the awesome default
    }
}
-- }}}

-- {{{ Rule definitions
-- Rules and applicable properties:
-- https://awesomewm.org/doc/api/libraries/awful.rules.html
local rules = {
    {
        -- Without any tag id - some apps need some properties to be set or tehy will misbehave.
        rules = {
            { rule = { class = "Gitg" },                             properties = { floating = true, size_hints_honor = true, width = 1850, height = 1000 } },

            { rule = { class = "Nm-connection-editor" },             properties = { floating = true, size_hints_honor = true } },
            { rule = { class = "Nitrogen" },                         properties = { floating = true, size_hints_honor = true } },

            { rule = { class = "SpeedCrunch" },                      properties = { floating = true, size_hints_honor = true, width = 800, height = 600 } },
            { rule = { class = "Arandr" },                           properties = { floating = true } },

            { rule = { class = "Pavucontrol" },                      properties = { floating = true } },
        }
    },

    -- Primary work tools
    {
        tagId = "primary",
        rules = {
            { rule = { class = "Unity", type = "normal" },           properties = { floating = false } },
        }
    },

    -- Secondary work tools
    {
        tagId = "secondary",
        rules = {
            { rule = { class = "Walnut" },                           properties = { floating = true } },
            { rule = { class = "openwalnut" },                       properties = { floating = true } },
            { rule = { class = "Openwalnut" },                       properties = { floating = true } },

            { rule = { class = "UnityHub" },                         properties = { floating = false } },
            { rule = { class = "unityhub" },                         properties = { floating = false } },
        }
    },

    -- Multimedia stuff
    {
        tagId = "media",
        rules = {
            { rule = { class = "Totem" },                            properties = {  } },
            { rule = { class = "vlc" },                              properties = {  } },
            { rule = { class = "MPlayer" },                          properties = { floating = true } },
            { rule = { class = "[Ss]potify" },                       properties = { floating = false } },
            { rule = { class = "Deadbeef" },                         properties = { floating = true } },
            { rule = { class = "Audacious" },                        properties = {  } },
        }
    },

    -- Browsing
    {
        tagId = "www",
        rules = {
            { rule = { class = "firefox" },                          properties = { } },
            { rule = { class = "Firefox" },                          properties = { } },
            { rule = { class = "firefox", name = "Download" },       properties = { floating = true } },
            { rule_any = { class = { "google-chrome", "Google-chrome" } }, properties = { tagId = "www" } },
        }
    },

    -- PIM, Chat, Mail
    {
        tagId = "mail",
        rules = {
            -- EMail
            { rule = { class = "UXTerm", name = "Mutt" },            properties = { } },
            { rule = { class = "thunderbird" },                      properties = { } },
            { rule = { class = "UXTerm", name = ".*ommunicator.*" }, properties = { } },

            -- Chatting
            { rule = { class = "TelegramDesktop" },                  properties = { size_hints_honor = true }, callback = awful.client.setslave },
            { rule = { class = "Signal" },                           properties = { size_hints_honor = true, floating = false, },  callback = awful.client.setslave },
            { rule = { class = "Slack" },                            properties = { size_hints_honor = true, floating = false, },  callback = awful.client.setslave },
            { rule = { class = "discord" },                          properties = { size_hints_honor = true, floating = false, },  callback = awful.client.setslave },
            { rule = { class = "Rocket.Chat" },                      properties = { size_hints_honor = true, floating = false, },  callback = awful.client.setslave },
            { rule = { class = "Ferdium" },                          properties = { size_hints_honor = true, floating = false, },  callback = awful.client.setslave },
        }
    },

    -- Drawing, artsy stuff
    {
        tagId = "draw",
        rules = {
            { rule = { class = "Blender" },                          properties = { floating = false } },
            { rule = { class = "Gimp" },                             properties = { floating = true } },
            { rule = { class = "Inkscape" },                         properties = { } },
        }
    },

    -- Guest systems, ...
    {
        tagId = "guests",
        rules = {
            { rule = { class = "VirtualBox" },                       properties = { floating = true } },
            { rule = { class = "VirtualBox Machine" },               properties = { floating = false } },
            { rule = { name = "Oracle VM VirtualBox Manager" },      properties = { floating = true, size_hints_honor = true } },
            { rule = { class = "Virt-manager" },                     properties = { } },
            { rule = { class = "Virt-viewer" },                      properties = { } },
            { rule = { class = ".qemu-system-x86_64-wrapped" },      properties = { } },
            { rule = { class = "Spicy" },                            properties = { } },
        }
    },

    -- Gaming
    {
        tagId = "games",
        rules = {
            { rule = { class = "Steam" },                            properties = { floating = true } },
            { rule = { class = "steam" },                            properties = { floating = true } },
            { rule = { class = "steamwebhelper" },                   properties = { floating = true } },
            { rule = { name = "Steam" },                             properties = { floating = true } },
            { rule = { class = "Lutris" },                           properties = { floating = true } },
            { rule = { class = "heroic" },                           properties = { floating = true } },
            { rule = { class = "SideQuest" },                        properties = { floating = true } },
            { rule = { class = "Wine" },                             properties = { floating = true } },
            { rule = { name = "PlayOnLinux" },                       properties = { floating = true } },
            { rule = { class = "yuzu" },                             properties = { floating = true } },
        }
    },

}
-- }}}

-- {{{ User commands
local commands = {
    -- Def
    terminal = "kitty", --"x-terminal-emulator",

    -- User/Power management
    sys = {
        logout = 'echo "awesome.quit()" | /usr/bin/awesome-client',
        restart = "systemctl reboot",
        hibernate = "systemctl hibernate",
        suspend = "systemctl suspend",
        shutdown = "systemctl poweroff",
        lock = bin .. "lockoff"
    },

    -- Laptop light control
    light = {
        monUp = bin .. "mon-backlight incr",
        monDown = bin .. "mon-backlight decr",
        get = bin .. "mon-backlight get",
    },

    -- Volume special keys
    volume = {
        up =  bin .. "audio-volume incr",
        down =  bin .. "audio-volume decr",
        mute = bin .. "audio-volume mute",
        mixer = "pavucontrol",
        get = bin .. "audio-volume get"
    },

    -- Music special keys
    music = {
        play = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause",
        stop = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop",
        prev = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous",
        next = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
    },

    -- System monitors
    monitors = {
        cpu = "kitty htop -t",
        mem = "kitty htop -s PERCENT_MEM",
        bat = "kitty sudo powertop" -- NOTE: use uxterm as other terms do not find sudo/powertop ?!
    },

    -- Runners
    prompts = {
        run = 'rofi -modi drun,window -show combi',
        places = bin ..'dmenu_places',
        pass = 'rofi-pass',
        clipboard = 'rofi -modi "clipboard:greenclip print" -show clipboard -run-command "{cmd}"'
    },

    -- Apps
    apps = {
        calc = 'speedcrunch'
    },
}
-- }}}

-- {{{ Spawn keybindings - they spawn the user commands.
local spawnBindings = {
    -- Terminal spawn
    {{modkey}, "Return", commands.terminal},

    -- Lock screen
    {{"Mod1", "Control"}, "Delete", commands.sys.lock},

    -- Prompts
    {{modkey}, "a", commands.prompts.run},
    {{modkey}, "s", commands.prompts.places},
    {{modkey}, "p", commands.prompts.pass},
    {{modkey}, "v", commands.prompts.clipboard},

    -- Monitor backlight
    {{}, "XF86MonBrightnessUp", commands.light.monUp},
    {{}, "XF86MonBrightnessDown", commands.light.monDown},

    -- Volume
    {{modkey}, "x", commands.volume.up},
    {{modkey}, "z", commands.volume.down},
    {{}, "XF86AudioRaiseVolume", commands.volume.up},
    {{}, "XF86AudioLowerVolume", commands.volume.down},
    {{}, "XF86AudioMute", commands.volume.mute},

    -- Music
    {{}, "XF86AudioPlay", commands.music.play},
    {{}, "XF86AudioPrev", commands.music.prev},
    {{}, "XF86AudioNext", commands.music.next},

    -- Apps
    {{modkey}, "c", function () awful.spawn.raise_or_spawn(commands.apps.calc, {}, function (c) return c.class == "SpeedCrunch" end) end},
}
-- }}}

return {
    modkey = modkey,
    style = style,
    commands = commands,
    keybindings = {
        spawn = spawnBindings
    },
    tagging = tagging,
    rules = rules,
    clients = clients,
}
