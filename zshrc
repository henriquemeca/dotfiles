# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.powerlevel10k/powerlevel10k.zsh-theme # Powerlevel10k theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source files
source $(dirname $(gem which colorls))/tab_complete.sh #https://github.com/athityakumar/colorls - Colors on ls command
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh # Zsh autocomplete
source ~/.credentials.sh # Export credentials

# Paths
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin


#Aliases

alias v="nvim"
alias lzd="lazydocker"
alias l='colorls -A --sd'
alias la='colorls -lA --sd'
alias cdg='cd ~/github && cd $(find . -type d | fzf)'
alias gd='gh dash'
#alias export_env="export $(grep -v '^#' .env | xargs -0)"

## tmux
alias ta="tmux a"
alias tn="tmux new -s"

## Git
alias ga="git add"
alias gcm="git commit -m"
alias gco="git checkout"
alias gst="git status"

##########
# Python #
##########
alias poetry_activate="source $(poetry env info --path)/bin/activate"

#setup pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


###########
#Functions#
###########

# cd folders with fzf 
cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -e +m) && \
  cd "$dir"
}

# Export env variables from .env file
export_env(){
    unamestr=$(uname)
    if [ "$unamestr" = 'Linux' ]; then
      export $(grep -v '^#' .env | xargs -d '\n')
    elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
      export $(grep -v '^#' .env | xargs -0)

    fi
}

## remove folders containing only __pycache__ files
function rm-pycache() {
    files=$(find . | grep -E '(/__pycache__$|\.pyc$|\.pyo$)')
    if [[ -z $files ]]; then
        echo "No files to be removed."
    else
        echo "Files to be removed: $files"
        echo $files | xargs rm -rf
    fi
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/henriquebrito/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/henriquebrito/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
