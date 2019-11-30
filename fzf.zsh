# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/tfruetel/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/tfruetel/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/tfruetel/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/tfruetel/.fzf/shell/key-bindings.zsh"
