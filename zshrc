# about pulse secure
# startvpn() {
#   launchctl load -w /Library/LaunchAgents/net.pulsesecure.pulsetray.plist
# }
# quitvpn() {
#   launchctl unload -w /Library/LaunchAgents/net.pulsesecure.pulsetray.plist
#   osascript -e 'tell application "Pulse Secure" to quit'
# }

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%    C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias preview="fzf --preview 'bat --color \"always\" {}'"

alias {vi,vim}='nvim'
alias ls='exa'

export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:~/.local/bin
source ~/.iterm2_shell_integration.zsh

alias fetch_papers="rclone sync -i Zotero:GoodNotes/ ~/GoodNotes/"
alias update_papers="rclone sync -i ~/Papers/ Zotero:Zotero/ && rclone sync -i ~/GoodNotes/ Zotero:GoodNotes/"

function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    else
        for n in "$@"
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.cbr|*.rar) unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *.cpio)      cpio -id < ./"$n"  ;;
                    *.cba|*.ace) unace x ./"$n"      ;;
                    *.zpaq)      zpaq x ./"$n"      ;;
                    *.arc)       arc e ./"$n"       ;;
                    *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                        extract $n.iso && \rm -f $n ;;
                                        *)
                                            echo "extract: '$n' - unknown archive method"
                                            return 1
                                            ;;
                                    esac
                                else
                                    echo "'$n' - file does not exist"
                                    return 1
            fi
        done
    fi
}

function suck {  
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: suck <link to file>"
    else

        if [ -x "$(command -v aria2c)" ]; then 
            aria2c --file-allocation=none -c -x 10 -s 10 "$1"
        elif [ -x "$(command -v wget)" ]; then
            wget -c "$1"
        else
            curl -L -O "$1"
        fi
    fi
}

export SPICETIFY_INSTALL="$HOME/.local/spicetify-cli"
export SPICETIFY_CONFIG="$HOME/.local/spicetify_data"
export PATH="$SPICETIFY_INSTALL:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk17-zulu/Contents/Home

if [ -x "$(command -v port)" ]; then
    export C_INCLUDE_PATH="/opt/local/include"
    export LIBRARY_PATH="/opt/local/lib"
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

function hitokoto {
    setopt localoptions nopromptsubst

  # Get hitokoto data
  local -a data
  data=("${(ps:\n:)"$(command curl -s --connect-timeout 2 "https://v1.hitokoto.cn" | command jq -j '.hitokoto+"\n"+.from')"}")

  # Exit if could not fetch hitokoto
  [[ -n "$data" ]] || return 0

  local quote="${data[1]}" author="${data[2]}"
  print -P "%F{3}${author}%f: “%F{5}${quote}%f”"
}


### Zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{160}Installing %F{33}ZINIT%F{160} Initiative Plugin Manager (%F{33}z-shell/zinit%F{160})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone -q https://github.com/z-shell/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# (this is currently required annexes)
zinit light-mode for \
    z-shell/z-a-readurl \
    z-shell/z-a-meta-plugins \
    annexes

### End of Zinit's installer chunk
zinit ice depth"1"
zinit light geometry-zsh/geometry


# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "$HOME/Workspace/kitty/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; then source "$HOME/Workspace/kitty/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION
