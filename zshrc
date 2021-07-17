export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%    C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias preview="fzf --preview 'bat --color \"always\" {}'"

alias {vi,vim}='nvim'

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    source ~/.iterm2_shell_integration.zsh
fi

export SPICETIFY_INSTALL="/Users/daydreamer/.local/spicetify-cli"
export SPICETIFY_CONFIG="/Users/daydreamer/.local/spicetify_data"
export PATH="$SPICETIFY_INSTALL:$PATH"
