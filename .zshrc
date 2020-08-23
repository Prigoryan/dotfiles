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

autoload -Uz compinit
compinit
# End of lines added by compinstall


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



unsetopt HIST_VERIFY
export EDITOR=nano

eval $(thefuck --alias)
source /usr/share/nvm/init-nvm.sh

alias mon='watch -n 1 "gpustat ; sensors | grep -P \"(^temp|^fan|^T)\""'
alias y=yay
alias rn=perl-rename
alias pacdiff='sudo sh -c "DIFFPROG=\"meld\" pacdiff"'
alias f=fuck

if [[ $1 == eval ]]
then
    "$@"
set --
fi
