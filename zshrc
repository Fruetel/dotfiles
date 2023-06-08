# User configuration

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/x86_64:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(/opt/homebrew/bin/brew --prefix openssl@1.1)"
export GPG_TTY=$(tty)

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -Uz compinit && compinit

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle kubectl
#antigen bundle asdf
antigen bundle history-substring-search
antigen bundle chucknorris
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle caarlos0/ports

antigen theme denysdovhan/spaceship-prompt

# ORDER
SPACESHIP_PROMPT_ORDER=(
  time     #
  user     # before prompt char
  char
  dir
  git
  ruby
  elixir
  node
  golang
  xcode
  swift
  docker
  venv
  pyenv
)

antigen apply


export TERM=screen

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#source ~/.zsh_profile
source ~/.zprofile

bindkey -v

export CLICOLOR=1
#export TERM=xterm-256color

export AWS_ACCESS_KEY_ID=`awk -F "=" '/aws_access_key_id/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`
export AWS_SECRET_ACCESS_KEY=`awk -F "=" '/aws_secret_access_key/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`
export AWS_SESSION_TOKEN=`awk -F "=" '/aws_session_token/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`

alias ber='bundle exec rake'
alias bec='bundle exec cucumber'
alias be='bundle exec'

alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcl='docker-compose logs'
alias dcp='docker-compose ps'
alias dcbasic='docker-compose up -d postgres rabbitmq redis'
alias drnginx='docker-compose stop nginx && docker-compose up -d nginx'
alias ll='colorls --sort-dirs --report -al'
alias tm='tmux new -s `basename $PWD` || tmux a -t `basename $PWD`'

alias docker-rebuild='docker-compose stop && docker-compose rm -f && docker-compose build'
alias docker-test='docker-compose run app docker/bin/run test'
# if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

neofetch

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tfruetel/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tfruetel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tfruetel/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tfruetel/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="$PATH:/Users/tfruetel/.bin"
