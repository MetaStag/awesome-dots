# ZSH Config (~/.zshrc)
# --------------------------

# Prompt
PS1="%F{blue}%B%~%b%f %F{green}%BΨ%b%f "
export EDITOR=nvim

# Aliases
alias vim=nvim
alias apt='sudo apt'
alias ls='exa --group-directories-first'
alias ll='exa --icons -lh --no-user --no-time --group-directories-first'
alias la='exa --icons -lah --no-user --no-time --group-directories-first'
alias lt='exa --tree'
alias packages='dpkg --list | wc -l' # Check number of packages installed
alias du='du -hsc'
alias space='df -h | awk '\''/n1p5|sda3/ {print $6" - "$5" used"}'\''' # check used space in /root and /home

# History
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.config/zsh/history

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vim mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vim modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || # Normal Mode
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || # Insert Mode
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

bunnyfetch
