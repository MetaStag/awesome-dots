# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
unset rc

alias vim=nvim
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias packages='rpm -qa | wc -l'
alias space='df -h | awk '\''NR == 2 {print $3 " used out of " $4 " - " $5}'\'''
set -o vi
export PS1='\[\e[32m\]\w\[\e[0m\] Ψ '
