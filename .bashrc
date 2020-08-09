# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# function to display time on the right side of the terminal prompt
function prompt_command {
    #prompt_x is where to position the cursor to write the clock
    let prompt_x=$(tput cols)-7
    tput sc
    tput hpa $prompt_x
    echo -n "[$(date +%H:%M)]"
    tput rc
}

# set a fancy prompt (with color, if the terminal has the capability)
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='['
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    if [ "$USER" == "root" ]; then
        PS1="$PS1\[\e[1m\]\[\e[31m\]\u\[\e[00m\]" # red username
    else
        PS1="$PS1\[\e[1m\]\[\e[95m\]\u\[\e[00m\]" # green username
    fi
    # yellow hostname, blue working dir
    PS1="$PS1@\[\e[1m\]\[\e[33m\]\H${debian_chroot:+($debian_chroot)}\[\e[00m\]:\[\e[96m\]\[\e[1m\]\w\[\e[00m\]]\n\\\$ "
    #if [ -x /bin/date ]; then
    #    PROMPT_COMMAND=prompt_command
    #fi
else
    PS1='[\u@\H${debian_chroot:+($debian_chroot)}:\w]\n\$ '
fi

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\H${debian_chroot:+($debian_chroot)}:\w\a\]$PS1"
    ;;
esac

# enable color support of ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# alias for find in current directory and everywhere
alias f='find . -name'
alias fe='find / -name'

# grep colors
export GREP_COLORS='mt=03;107;36:sl=:cx=:fn=91;44;01:ln=32:bn=32:se=36'

# i3lock-fancy
alias xxx='i3lock-fancy'

# for gnome-control-center to work properly with i3
alias gnome-control-center='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'

# run powerline
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /home/massimiliano/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/massimiliano/python-devel/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/massimiliano/python-devel/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/massimiliano/python-devel/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/massimiliano/python-devel/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

