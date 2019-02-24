# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ldapvi="ldapvi -D uid=$USER,ou=People,dc=osuosl,dc=org -h ldaps://ldap1.osuosl.org"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

ZSH_THEME="refined"
  
#Environment Variable definitions export EDITOR='/usr/bin/vim' export VISUAL='/usr/bin/vim'
export PATH="$HOME/bin:/usr/local/bin:/opt/kitchen/bin:$PATH"
export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"

# source other garbage
otherscripts=(
  /etc/profile
  ~/.work_secretsrc
  ~/.work_specific
  $ZSH/oh-my-zsh.sh
  ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
)

for script in "$otherscripts[@]"; do
  if [ -f "$script" ]; then
    source "$script"
  fi
done

if which vim > /dev/null; then
  export EDITOR=vim
fi

if which chef > /dev/null; then
  eval "$(chef shell-init zsh)"
fi

force_color_prompt=yes

# Aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias c="clear"
alias config='vim ~/.config/terminator/config'
alias eb="$EDITOR ~/.bashrc"
alias gcf='git checkout --'
alias gc='git checkout'
alias gcm='git checkout master && git pull'
alias gl='git log --decorate --color --graph'
alias grc='git rebase --continue'
alias grm='git rebase master'
alias gs='git status'
alias kc='kitchen converge'
alias kd='kitchen destroy'
alias ke="kitchen exec $command"
alias kl='kitchen login'
alias kt='kitchen test'
alias kv='kitchen verify'
alias la='ls -A'
alias ll='ls -alF'
alias l='ls -CF'
alias nb='git checkout master && git pull origin master && git checkout -b'
alias project='vim -S $PROJECT_DIR/Session.vim'
alias resume='vim -S Session.vim'
alias rs='. ~/.bashrc'
alias sshstart='eval $(ssh-agent)'


if [ -f ~/.msg ]; then
  cat ~/.msg
fi

HISTCONTROL=ignoreboth
