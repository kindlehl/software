# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/kindlehl/.oh-my-zsh"
  export TERM="xterm-256color"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ldapvi="ldapvi -D uid=$USER,ou=People,dc=osuosl,dc=org -h ldaps://ldap1.osuosl.org"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#plugins=(
  #git
#)
#~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/profile

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

#Environment Variable definitions export EDITOR='/usr/bin/vim' export VISUAL='/usr/bin/vim'
export EDITOR='/usr/bin/vim'
export PROJECT_DIR='/home/hunter/Projects/Scheduler'
export PATH="/opt/kitchen/bin:$PATH"
eval "$(chef shell-init zsh)"
source ~/.work_secretsrc
export PATH="/opt/kitchen/bin:$PATH"
eval $(keychain --quiet --nogui --eval ~/.ssh/id_rsa_ash ~/.ssh/id_rsa_fir ~/.ssh/id_rsa_openstack)




# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias config='vim ~/.config/terminator/config'
alias project='vim -S $PROJECT_DIR/Session.vim'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias c="clear"
alias gl='git log --decorate --color --graph'
alias gcm='git checkout master && git pull'
alias grm='git rebase master'
alias grc='git rebase --continue'
alias gs='git status'
alias gc='git checkout'
alias gcf='git checkout --'
alias sshstart='eval $(ssh-agent)'
alias eb="$EDITOR ~/.bashrc"
alias rs='. ~/.bashrc'
alias resume='vim -S Session.vim'
alias kc='kitchen converge'
alias kl='kitchen login'
alias kt='kitchen test'
alias kd='kitchen destroy'
alias ke="kitchen exec $command"
alias kv='kitchen verify'
alias nb='git checkout master && git pull origin master && git checkout -b'
if [ -f ~/.work_specific ]; then
    . ~/.work_specific
fi


HOSTNAME=$(hostname)

cat ~/.msg



waitfor() {
    shopt -s expand_aliases
    while true; do
        echo "Thank you for being lazy"
        echo "COMMAND: $2"
        echo "WATCHED FILES: $(echo $1)"
# The use of echo here forces the shell to perform globbing and expansions 
        inotifywait -e modify $(echo $1)
        echo "EXECUTING COMMAND"    
        $2  
        sleep 5
        clear
    done
}
# function that takes a list of usernames, and resets their passwords with randomly generated passwords, and puts the password in their homedir
# must be run as root
generate_pw_for (){
  for username in "$@"; do
    pw=$(pwgen 15 1)
    passwd $username <<EOF
$pw
$pw
EOF
    echo "This is a randomly generated password courtesy of OSUOSL. Please delete this after you change your password
    " > /home/${username}/password.deleteme
    echo "$pw" >> /home/${username}/password.deleteme
  done
}

rmtw() {
  sed 's/\s*$//' "$1" > ${1}.bak
  mv ${1}.bak "$1"
}

digs() {
  dig "$1" | grep -A 2 ANSWER
}

digx() {
  dig -x "$1" | grep -A 2 ANSWER
}

shady () {
  ssh-add ~/.ssh/id_rsa_$1
}

d() {
  cd $@ && ls
}

e(){
  $@ 2>&1 >/dev/null & disown
}

mistake() {
  git commit -a --amend <<EOF
:wq
EOF
  git push origin -f HEAD
}

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
unalias -m *
if [ -f ~/.work_specific ]; then
    . ~/.work_specific
fi
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"
source $ZSH/oh-my-zsh.sh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PATH="/home/kindlehl/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kindlehl/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kindlehl/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kindlehl/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kindlehl/perl5"; export PERL_MM_OPT;

cat ~/.msg

