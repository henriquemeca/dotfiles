# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source files
source $(dirname $(gem which colorls))/tab_complete.sh #https://github.com/athityakumar/colorls - Colors on ls command
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.powerlevel10k/powerlevel10k.zsh-theme
source $(dirname $(gem which colorls))/tab_complete.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Paths
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin


#Aliases

alias v="nvim"
alias ta="tmux a"
alias lzd="lazydocker"
alias l='colorls -A --sd'
alias la='colorls -lA --sd'

## Git
alias ga="git add"
alias gcm="git commit -m"
alias gco="git checkout"
alias gst="git status"


# Functions
cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -e +m) && \
  cd "$dir"
}
