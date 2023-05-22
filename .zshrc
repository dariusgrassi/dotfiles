# ALIASES
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# ZSH_THEME="agnoster"
KEYTIMEOUT=1

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000

# Load aliases and shortcuts if existent.
alias brall="brew update && brew upgrade && brew cleanup && brew doctor"
alias tl="tmux ls"
alias gs="git status"
alias -- -="cd -"
alias python="python3"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
#bindkey -v
#bindkey -e
#export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey "^R" history-incremental-pattern-search-backward

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# SOURCES
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source ~/.bashrc
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.1.1/bin:$PATH"
export PATH=$PATH:/Users/dariusgrassi/.spicetify
export PATH=$PATH:/usr/local/go/bin

