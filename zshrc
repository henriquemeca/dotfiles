# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.powerlevel10k/powerlevel10k.zsh-theme # Powerlevel10k theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Setup NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Paths
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin


#Aliases

alias v="nvim"
alias lzd="lazydocker"
alias l='colorls -A --sd'
alias la='colorls -lA --sd'
alias cdg='cd ~/github && cd $(find . -type d | fzf)'
alias get_news='curl getnews.tech'
alias get_news_business='curl gr.getnews.tech/category=business'
#alias export_env="export $(grep -v '^#' .env | xargs -0)"

## tmux
alias ta="tmux a"
alias tn="tmux new -s"

## Git
#alias ga="git add"
#alias gcm="git commit -m"
#alias gco="git checkout"
#alias gst="git status"
alias gd='gh dash'
#alias gf='gh fzrepo'


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

#Query json from GCS and prints it with `JQ`
failed_indicators() {
    gsutil cp $1/failed_indicators.json - | jq
}
failed_indicators_on_date() {
    if [ -z "$1" ]; then
        local current_date=$(date +'%Y-%m-%d')
    else
        local current_date=$1
    fi
    
    local indicator_types=("analytics" "contractual" "regulatory" "securitization")
    
    for type in "${indicator_types[@]}"; do
        echo $type
        gsutil cp "$KORUJA_LOGS_PATH/at=$current_date/indicator_type=$type/failed_indicators.json" - | jq
    done
}
####################
#   GPT functions  #
####################

g() {
  sgpt "$*"
}

gc() {
  sgpt --chat tmp "$*"
}

go() {
  sgpt --code "$*"
}

gco() {
  sgpt --code --chat tmp "$*"
}
####################
# Python functions #
####################
#setup pyenv


pyenv_seup() {
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
}
poetry_activate () {
    source $(poetry env info --path)/bin/activate
}



## remove folders containing only __pycache__ files
function rm-pycache() {
    # Define the white-listed directories (directories to exclude)
    white_list=( ".git" ".venv" "venv" )

    # Convert the white_list array into a string of -path exclusion arguments for find
    prune_args=""
    for dir in "${white_list[@]}"; do
        prune_args+=" -path ./$dir -prune -o"
    done

    # Find and remove __pycache__ directories and .pyc/.pyo files, excluding white-listed directories
    eval "find . ${prune_args} -type f \( -name '*.pyc' -o -name '*.pyo' \) -print -o -type d -name '__pycache__' -print" | while read -r file; do
        echo "File to be removed: $file"
        rm -rf "$file"
    done

    # Find and remove empty directories
    eval "find . ${prune_args} -type d -empty -print" | while read -r dir; do
        echo "Empty directory to be removed: $dir"
        rmdir "$dir"
    done
}
################
# Source files #
#$##############
source $(dirname $(gem which colorls))/tab_complete.sh #https://github.com/athityakumar/colorls - Colors on ls command
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh # Zsh autocomplete
source ~/.credentials.sh # Export credentials

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/henriquebrito/.gsutil/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/henriquebrito/.gsutil/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/henriquebrito/.gsutil/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/henriquebrito/.gsutil/google-cloud-sdk/completion.zsh.inc'; fi


################
# Git Functions#
################
