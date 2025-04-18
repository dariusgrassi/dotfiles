# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# instant prompt starts the prompt instantly while zsh modules are still
# loading in the background, making zsh appear faster
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# allows zsh to find homebrew packages
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# this enables the powerlevel10k plugin, a theme for zsh's prompt
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# this is my user-local config of powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# this enables another prompt plugin, zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# this enables a vi keymap for zsh; need explicit ctrl R after
bindkey -v
bindkey '^R' history-incremental-search-backward

# now i want to make ls have some nice colors
alias ls='ls --color=auto'
alias cp='cp -v'

# this starts the zsh completion system
autoload -Uz compinit && compinit

# this tells zsh to match any lowercase or capital letters with any
# lowercase or capital letters, only if there are no case-sensitive
# matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# this highlights menus as you tab through them
zstyle ':completion:*' menu select

# i use shell integration because it makes it easy to copy shell output
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

