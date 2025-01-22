# ==== GIT ====
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }
setopt prompt_subst

# ==== EXPORTS ====
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PROMPT='%B%F{124}%t%f%b - %B%F{31}%n%f%b:%~ | %B%F{208}${vcs_info_msg_0_} %B%F{white}'
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export MANPAGER="nvim +Man!"

# ==== ALIASES ====
alias l="ls"
alias ll="ls -lah"
alias et="emacsclient -t"
alias pp="php bin/console"
alias n=$EDITOR

# ==== FUNCTIONS ====
autoload -Uz compinit
compinit
for func_file in ~/.config/zshFunctions/*; do
    source $func_file
done

# ==== LOADINGS ====
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

