#Aliases

alias v="nvim"
alias vc="nvim ~/.credentials.sh"
alias lzd="lazydocker"
alias l='colorls -A --sd'
alias la='colorls -lAh --sd'
alias cdg='cd ~/github && cd $(find . -type d | fzf)'
alias cdd='cd ~/dotfiles && nvim .'
alias aider='$HOME/.local/pipx/venvs/aider-chat/bin/aider'

## tmux
alias t="tmux"
alias ta="tmux a"
alias tn="tmux new -s"

## Programming
alias dc="docker-compose"
alias dcr="docker-compose down && docker-compose up -d"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dj='python manage.py' # django
alias pa="php artisan"
alias gm="go mod"
alias gr="go run"
alias gt="go test"
alias gb="go build"
alias pn="pnpm"


## Git
#alias ga="git add"
#alias gcm="git commit -m"
#alias gco="git checkout"
#alias gst="git status"
alias gd='gh dash'
alias gc='git clone'
#alias gf='gh fzrepo'


###########
#Functions#
###########

# Pet
function p() {
    pet clip
}

cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -e +m) && \
  cd "$dir"
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
dataproc_batch_logs() {
  if [[ -z "$1" ]]; then
    echo "You must provide a batch ID."
    return 1
  fi

  local BATCH_ID=$1
  local PROJECT_ID=$GOOGLE_CLOUD_PROJECT
  local REGION=$GOOGLE_CLOUD_REGION

  # Describe the Dataproc batch using the provided ID
  gcloud dataproc batches describe $BATCH_ID --region=$REGION --project=$PROJECT_ID
}

####################
# Python functions #
####################

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
################
#Setup Modules
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/go/bin:~/.cargo/bin:/opt/nvim/bin
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Setup NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

################
# Miscelaneous #
#$##############
# Setup zsh
#source /opt/homebrew/opt/modules/init/zsh
# Setup pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
##Setup zoxide
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh # Zsh autocomplete
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh # Zsh autocomplete
#[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
source ~/.credentials.sh # Export credentials
#source /Users/henriquebrito/github/cloud-composer-repo/.cloud_composer_source.sh
#source /Users/henriquebrito/github/report-hub/.report_hub_source.sh

# Python repositories
export_env() {
    export $(grep -v '^#' .env | xargs)
}

if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

if [ -d ".venv" ]; then
    source .venv/bin/activate
    export PYTHONPATH="$(pwd):$PYTHONPATH"
    echo "venv initialized"
fi

source /Users/henrique.brito/github/cloud-composer-repo/.cloud_composer_source.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/henrique.brito/.gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/henrique.brito/.gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/henrique.brito/.gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/henrique.brito/.gcloud/google-cloud-sdk/completion.zsh.inc'; fi
