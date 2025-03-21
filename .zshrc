# ==== GIT ====
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'
precmd() { vcs_info }
setopt prompt_subst

# ==== EXPORTS ====
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export PROMPT='%B%F{#658594}%n%f%b%F{#c5c9c5}:%~ | %B%F{#c4746e}󰊢 ${vcs_info_msg_0_} '
export RPROMPT='%B%F{#c5c9c5}[%B%F{#c5c9c5}%t%f%b%B%F{#c5c9c5}]'
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export MANPAGER="nvim +Man!"

# ==== ALIASES ====
alias l="ls"
alias ll="ls -lah"
alias pp="php bin/console"
alias n=$EDITOR
alias nn="$EDITOR ."
alias zl="zellij"

# ==== FUNCTIONS ====
for func_file in ~/.config/zshFunctions/*; do
    source $func_file
done

# ==== LOADINGS ====
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ==== BREW ====
autoload -Uz compinit
compinit
