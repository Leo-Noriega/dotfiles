autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }

setopt prompt_subst

export PATH="$HOME/.config/emacs/bin:$PATH"
export PROMPT='%B%F{196}%t%f%b - %B%F{23}%n%f%b:%~ | %B%F{208}${vcs_info_msg_0_} %B%F{white}'

export EDITOR="emacsclient -c"
export TERMINAL="alacritty"
