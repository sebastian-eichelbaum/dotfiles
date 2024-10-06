eval "$(starship init zsh)"

#############################################################################################################
# {{{ Environment Vars
#

# Add .local/bin. NOTE: on nix, this is done by the configuration already.
PATH=~/.local/bin:$PATH
export RIPGREP_CONFIG_PATH=~/.config/ripgrep.conf

# }}}

#############################################################################################################
# {{{ Behavior
#

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or

# Ensure LS_COLORS is set. The completion systen uses it too.
eval `dircolors -b`

# }}}

#############################################################################################################
# {{{ Aliases
#

# Share the current dir
# alias share='sudo python3 -m http.server 80'

# Open Nvim in a new terminal
gvim() {
    $TERMINAL -e nvim "$@" &
}

# Colorful grep
# export GREP_COLORS='mt=33'
# alias grep='grep --color=auto'

# Lazy abrev
alias gitgui=gittyup

# I want to include dot files in search by default
alias fd='fd --hidden --exclude ".git"'

# Nice colored cat
alias cat='bat --paging=never'
alias autorandr='autorandr --match-edid'

# }}}

#############################################################################################################
# {{{ History
#

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Avoid storing duplicates, including those that differ only by blanks
setopt hist_ignore_all_dups
setopt HIST_REDUCE_BLANKS

# SHare history between sessions
setopt sharehistory

# Keybindings Arrow-Up and Down to search the history
zmodload zsh/terminfo

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    # Mac specific - get codes by typing "read"
    bindkey "^[[A" up-line-or-beginning-search
    bindkey "^[[B" down-line-or-beginning-search
else
    # Works everywhere except mac
    bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
    bindkey "$terminfo[kcud1]" down-line-or-beginning-search
fi

# }}}

#############################################################################################################
# {{{ Autocomplete
#

# Get rid of the annoying "zsh: do you wish to see all 168 possibilities (57 lines)?" message
LISTMAX=-1

# Extended completions DB
fpath=(~/.zsh/zsh-completions/src $fpath)
# Add Nix completions
fpath=(~/.zsh/zsh-completions/src $fpath)

# Init auto complete
autoload -Uz compinit
compinit -i

### Behavior

# Configure what the completer should suggest. Also, refer to
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Control-Functions
zstyle ':completion:*' completer_complete _correct _approximate
#zstyle ':completion:*' completer _expand _complete _correct _approximate

# Cache results? Can speed up things like APT completion
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path "~/.zcompcache"

# Enable menu for long lists, allow selection via tab then cursor
zstyle ':completion:*' menu yes select
# zstyle ':completion:*' menu yes=long select

# Allow to complete "." and ".."
zstyle ':completion:*' special-dirs true

### Visual Style

# Group the different type of matches under their descriptions
zstyle ':completion:*' group-name ''

# Color the descriptions and correction headlines in completions.
zstyle ':completion:*:*:*:*:descriptions' format '%B%F{244}-- %d --%f%b'
zstyle ':completion:*:*:*:*:corrections' format '%B%F{yellow}-- %d (errors: %e) --%f%b'

# Use ls like colors in file lists
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=38;5;214;1"
# With gray bg
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;237;38;5;214;1"

### Tool-specific:

# Kill/killall, ... tools that use PID or process names.
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'

zstyle ':completion:*' verbose true

# }}}

#############################################################################################################
# {{{ fzf integration
#

# FZF is configured using some env vars.
if [ -f ~/.config/fzf ]; then
    source ~/.config/fzf
fi

# There is a more complex FZF plugin. It replaces the ZSH menu with fzf everywhere.
#
# git clone https://github.com/Aloxaf/fzf-tab ~/.zshrc
# source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

# To make grouping work, some things need to be configured differently
#zstyle ':completion:*:descriptions' format '[%d]'
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Also, disable the above completion:*:*:*:*:descriptions formats.

# Use the history search (CTRL-r) and filesearch (**<TAB> or CTRL-t) provided by fzf:
# NOTE: this is NixOS specific. Adapt to others as needed
if [ -d /run/current-system/sw/share/fzf ]; then
    source /run/current-system/sw/share/fzf/completion.zsh
    source /run/current-system/sw/share/fzf/key-bindings.zsh
fi

# }}}

#############################################################################################################
# {{{ nix-shell integration
#

export NIXPKGS_ALLOW_UNFREE=1

# If not used, nix-shell always spawns a shell with bash. This plugin switches to zsh automatically.
if [ -f ~/.zsh/zsh-nix-shell/nix-shell.plugin.zsh ]; then
    source ~/.zsh/zsh-nix-shell/nix-shell.plugin.zsh
fi

# }}}

#############################################################################################################
# {{{ Autosuggestons
#

if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=007"
    ZSH_AUTOSUGGEST_USE_ASYNC=1
fi

# }}}

#############################################################################################################
# {{{ Syntax Highlighter
#

# Syntax highlight
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # By default, it is too noisy (colorful). I prefer a more subtle style that does not get in the way
    # and only highlights important stuff, like "rm -rf".
    #
    # refer to https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md

    # syntax color definition
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main regexp)

    typeset -A ZSH_HIGHLIGHT_STYLES
    typeset -A ZSH_HIGHLIGHT_REGEXP

    # Regex
    ZSH_HIGHLIGHT_REGEXP+=('\bsudo\b' fg=208,bold)
    ZSH_HIGHLIGHT_REGEXP+=('\brm -rf\b' fg=208,bold)

    # Main
    ZSH_HIGHLIGHT_STYLES[default]=none
    #ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[unknown-token]=none

    # Keyword-alike and shell syntax
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=012,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=012,bold
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=012,bold
    ZSH_HIGHLIGHT_STYLES[function]=fg=012,bold

    # Commands
    ZSH_HIGHLIGHT_STYLES[alias]=none
    ZSH_HIGHLIGHT_STYLES[global-alias]=none
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=none
    ZSH_HIGHLIGHT_STYLES[builtin]=none
    ZSH_HIGHLIGHT_STYLES[command]=none

    # - ?
    ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=013

    # Paths and files
    ZSH_HIGHLIGHT_STYLES[path]=fg=none
    #ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=208,bold
    # - While typing a path, this color is used when the already typed stuff is part of an existing path
    #ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=208,bold
    #ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=fg=208,bold
    # - If Auto-cd is active
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=none
    # The * and stuff for filename globbing
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=208

    # !foo and ^foo^bar
    ZSH_HIGHLIGHT_STYLES[history-expansion]=none

    # - Stuff like $(echo ls)
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]=none
    # - the $( and )
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=012,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]=fg=012,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]=fg=012,bold
    # - process substitutions (<(echo foo))
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    # - process substitution delimiters (<( and ))
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=012,bold

    # - single-hyphen options (-o)
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=248,bold
    # - double-hyphen options (--option)
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=248,bold

    # - backtick command substitution (`foo`)
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    # - unclosed backtick command substitution (`foo)
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]=none
    # - backtick command substitution delimiters (`)
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=012,bold

    # - single-quoted arguments ('foo')
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=green,bold
    # - unclosed single-quoted arguments ('foo)
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]=fg=green,bold
    # - double-quoted arguments ("foo")
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=green,bold
    # - unclosed double-quoted arguments ("foo)
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]=fg=green,bold
    # - dollar-quoted arguments ($'foo')
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=green,bold
    # - unclosed dollar-quoted arguments ($'foo)
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]=fg=green,bold
    # - two single quotes inside single quotes when the RC_QUOTES option is set ('foo''bar')
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=green,bold
    # - parameter expansion inside double quotes ($foo inside "")
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=012,bold
    # - backslash escape sequences inside double-quoted arguments (\" in "foo\"bar")
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=015,bold
    # - backslash escape sequences inside dollar-quoted arguments (\x in $'\x48')
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=015,bold

    # - parameter assignments (x=foo and x=( ))
    ZSH_HIGHLIGHT_STYLES[assign]=fg=012,bold
    # - redirection operators (<, >, etc)
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=012,bold
    # - comments, when setopt INTERACTIVE_COMMENTS is in effect (echo # foo)
    ZSH_HIGHLIGHT_STYLES[comment]=none
    # - elided parameters in command position ($x ls when $x is unset or empty)
    ZSH_HIGHLIGHT_STYLES[comment]=none
    # - named file descriptor (the fd in echo foo {fd}>&2)
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    # - numeric file descriptor (the 2 in echo foo {fd}>&2)
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    # - a command word other than one of those enumerated above (other than a command, precommand, alias, function, or shell builtin command).
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=green,bold
fi
# }}}

#############################################################################################################
# {{{ Quirks
#

# Ensure a locale is set on MacOS
case `uname` in
    Darwin)
        echo "Using Locale Hack. Check if still needed?"
        export LC_ALL=en_US.UTF-8
        export LANG=en_US.UTF-8
    ;;
esac

# }}}

#############################################################################################################
# {{{ Chainload System Specifics
#

hostzshrc="$HOME/.zshrc.$HOST"
if [ -r $hostzshrc ]; then
    source $hostzshrc
fi

# }}}

