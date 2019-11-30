# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# User configuration

  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle asdf
antigen bundle chucknorris
antigen bundle history-substring-search
antigen bundle chucknorris
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-syntax-highlighting
antigen bundle zsh-autosuggestions
antigen bundle z

#antigen theme agnoster
#antigen theme robbyrussell
#antigen theme nanotech
antigen theme denysdovhan/spaceship-prompt
# ORDER
SPACESHIP_PROMPT_ORDER=(
  time     #
  user     # before prompt char
  char
  dir
  git
  node
  ruby
  xcode
  swift
  golang
  docker
  venv
  pyenv
)

antigen apply

autoload -Uz compinit && compinit

export TERM=xterm-color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tfruetel/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tfruetel/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tfruetel/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tfruetel/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

$(brew --prefix asdf)/asdf.sh
$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

source ~/.zsh_profile

#eval "$(lua /usr/local/bin/z.lua --init zsh)"

eval $(thefuck --alias)
