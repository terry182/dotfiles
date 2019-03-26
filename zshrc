

#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh



# git lg
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%    C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

export PYENV_ROOT="~/.local/src/pyenv"
export PATH="$PYENV_ROOT/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/Library/TeX/texbin/"
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/Workspace/go"
export HOMEBREW_NO_AUTO_UPDATE=1

startvpn() {
  launchctl load -w /Library/LaunchAgents/net.pulsesecure.pulsetray.plist
}
quitvpn() {
  launchctl unload -w /Library/LaunchAgents/net.pulsesecure.pulsetray.plist
  osascript -e 'tell application "Pulse Secure" to quit'
}


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias preview="fzf --preview 'bat --color \"always\" {}'"
