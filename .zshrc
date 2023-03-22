# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(docker docker-compose systemd zsh-autosuggestions zsh-completions)
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
export ZSH=/usr/share/oh-my-zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu yes select search


autoload -Uz compinit
compinit
# End of lines added by compinstall

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# source /usr/share/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# bindkey '^I' fzf_completion

i3prop() {
  # Source: https://faq.i3wm.org/question/2172/how-do-i-find-the-criteria-for-use-with-i3-config-commands-like-for_window-eg-to-force-splashscreens-and-dialogs-to-show-in-floating-mode.1.html
  # i3-get-window-criteria - Get criteria for use with i3 config commands

  # To use, run this script, then click on a window.
  # Output is in the format: [<name>=<value> <name>=<value> ...]

  # Known problem: when WM_NAME is used as fallback for the 'title="<string>"' criterion,
  # quotes in "<string>" are not escaped properly. This is a problem with the output of `xprop`,
  # reported upstream: https://bugs.freedesktop.org/show_bug.cgi?id=66807

  PROGNAME=`basename "$0"`

  # Check for xwininfo and xprop
  for cmd in xwininfo xprop; do
      if ! which $cmd > /dev/null 2>&1; then
          echo "$PROGNAME: $cmd: command not found" >&2
          exit 1
      fi
  done

  match_int='[0-9][0-9]*'
  match_string='".*"'
  match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

  {
      # Run xwininfo, get window id
      window_id=`xwininfo -int | sed -nre "s/^xwininfo: Window id: ($match_int) .*$/\1/p"`
      echo "id=$window_id"

      # Run xprop, transform its output into i3 criteria. Handle fallback to
      # WM_NAME when _NET_WM_NAME isn't set
      xprop -id $window_id |
          sed -nr \
              -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
              -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
              -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
              -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
              -e '${g; p}'
  } | sort | tr "\n" " " | sed -r 's/^(.*) $/[\1]\n/'
}

cool-cp() {
  if [ ! -d ${@: -1} ]; then
    mkdir -p ${@: -1}
  fi
  /usr/bin/cp -R ${@: -2: 1} ${@: -1}
}


unsetopt HIST_VERIFY
export EDITOR=micro

eval $(thefuck --alias)
source /usr/share/nvm/init-nvm.sh

alias mon='watch --color -n 0.1 "nvidia-smi | grep -P \".*%.*C.*W.*%\" ; sensors | grep -P \"(^temp|^fan|^T)\""'
alias y=paru
alias rn=perl-rename
# alias cp=cool-cp
alias pacdiff='sudo sh -c "DIFFPROG=\"meld\" pacdiff"'
alias kshutdown='qdbus org.kde.Shutdown /Shutdown logoutAndShutdown'
alias kreboot='qdbus org.kde.Shutdown /Shutdown logoutAndReboot'
alias plasmarestart='kquitapp5 plasmashell || killall plasmashell && kstart5 plasmashell &> /dev/null'
alias f=fuck
alias rsync-achxzP='rsync -achxzP --info=progress2'

export WORDCHARS='-~'
bindkey '^H' backward-kill-word

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

if [ -f /etc/bash.command-not-found ]; then
        . /etc/bash.command-not-found
fi
