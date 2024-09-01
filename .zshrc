#Aliases

alias v="nvim"
alias lzd="lazydocker"
alias l='colorls -A --sd'
alias la='colorls -lAh --sd'
alias cdg='cd ~/github && cd $(find . -type d | fzf)'
alias cdd='cd ~/.dotfiles && nvim .'
#alias export_env="export $(grep -v '^#' .env | xargs -0)"

## tmux
alias t="tmux"
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

funds() {
    bq query --use_legacy_sql=false 'SELECT id, name, slug FROM hub.funds ORDER BY 1'
}

download_reports() {
    DESTINATION_DIR="$HOME/fund-reports/"
    if [ ! -d "$DESTINATION_DIR" ]; then
        mkdir -p "$DESTINATION_DIR"
        echo "Directory $DESTINATION_DIR created."
    else
        echo "Directory $DESTINATION_DIR already exists."
    fi

    gsutil -m rsync -d -r "gs://kanastra-tech-hub-production/fund-reports/" "$DESTINATION_DIR"
}

python_details() {
    echo "About python3"
    which python3
    python3 --version

    command_exists() {
        command -v "$1" >/dev/null 2>&1
    }

    if command_exists pyenv; then
        echo -e "\nAbout pyenv"
        pyenv versions
    fi

    if command_exists poetry; then
        echo -e "\nAbout poetry"
        poetry --version
        which poetry
        poetry env list
        poetry env info
    fi

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
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


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
# Miscelaneous #
#$##############
eval "$(zoxide init zsh)"

################
# Source files #
################
#Setup Modules
source /opt/homebrew/opt/modules/init/zsh
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Setup NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source $(dirname $(gem which colorls))/tab_complete.sh #https://github.com/athityakumar/colorls - Colors on ls command
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh # Zsh autocomplete
source ~/.credentials.sh # Export credentials
source /Users/henriquebrito/github/cloud-composer-repo/.cloud_composer_source.sh
source /Users/henriquebrito/github/report-hub/.report_hub_source.sh

# Paths
extra_setups(){
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/henriquebrito/.gsutil/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/henriquebrito/.gsutil/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/henriquebrito/.gsutil/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/henriquebrito/.gsutil/google-cloud-sdk/completion.zsh.inc'; fi

}


