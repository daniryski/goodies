# aliases
alias sudo='sudo -E'
alias py='python3'
alias vi='vim'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# generic zsh options
setopt autocd # change directory without writing cd
setopt interactivecomments # allow bash-style comments in the shell
setopt magicequalsubst # enable filename expansion in 'x=filename'
setopt nonomatch # hide error messages for pattern which don't match
setopt notify # report the status of background jobs
setopt numericglobsort # sort filenames numerically when sensible
setopt promptsubst # enable command substitution in prompt

# bindings
bindkey -e # emacs bindings
bindkey ' ' magic-space # expand from history on whitespace

# completion
autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*' use-compctl false

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*' # match substrings case-insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct
zstyle ':completion:*' format "%F{green}-- %d --%f"
zstyle ':completion:*' group-name ''

# navigate through the completions using vim's shortcuts
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# show, and colour the matching processes for killing
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt share_history
alias history='history 0'

# format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

if [ -z '${debian_chroot:-}' ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set term's title, and print a newline before every prompt
TERM_TITLE='\033]0;${debian_chroot:+($debianchroot)} %n@%m: %~\007'

precmd() {
  print -Pn "$TERM_TITLE"

  if [ -z "$NEWLINE_BEFORE_PROMPT" ]; then
    NEWLINE_BEFORE_PROMPT=1
  else
    print ''
  fi

  git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
}

PROMPT_EOL_MARK='' # hide the default EOL character %

PROMPT=$'[${debian_chroot:+($debian_chroot) }${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }%B%F{%(#.red.blue)}%n@%m%f%b %B%F{green}%~%f%b${git_branch:+ %B($git_branch)%b}]%(#.#.$) '

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#777'
fi

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
