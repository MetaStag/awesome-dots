# ZSH Config (~/.zshrc)
# --------------------------

# Prompt
PS1="%F{blue}%B%~%b%f %F{207}%Bⵃ%b%f "
export EDITOR=nvim

# Aliases
alias vim=nvim
alias cat=bat # bat is a cat clone with syntax highlighting and git integration
alias ls='exa --group-directories-first' # exa is an ls clone with colors, icons and better -lh output
alias ll='exa -lgh --icons --group-directories-first'
alias la='exa -lgha --icons --group-directories-first'
alias pacman='sudo pacman --color=auto'
alias update='sudo pacman -Syu'
alias packages='sudo pacman -Q | wc -l' # Check number of packages installed
alias sl='sl | lolcat'
alias unimatrix='unimatrix -lg -s 95 | lolcat' # Unimatrix with Greek characters and lolcat

# History
HISTSIZE=15
SAVEHIST=15
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
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Plugins
#source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
