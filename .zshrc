# ==== EXPORTS ====
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export PROMPT='%B%F{#658594}%n%f%b%F{#c5c9c5}:%~ | %B%F{#c4746e}󰊢 ${vcs_info_msg_0_} '
export RPROMPT='%B%F{#c5c9c5}[%B%F{#c5c9c5}%t%f%b%B%F{#c5c9c5}]'
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
export PATH="/Users/noriega/Downloads/sonar-scanner-7.0.2.4839-macosx-aarch64/bin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin/:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export MANPAGER="nvim +Man!"
export AIRFLOW_HOME="~/Documents/airflow"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# ==== ALIASES ====
alias l="ls"
alias ll="ls -lah"
alias pp="php bin/console"
alias n=$EDITOR
alias nn="$EDITOR ."
alias zl="zellij"
alias tx="tmux"

# ==== FUNCTIONS ====
for func_file in ~/.config/zshFunctions/*; do
    source $func_file
done

# ==== BREW ====
autoload -Uz compinit
compinit

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

ulimit -n 2048

# ==== Starship ====
eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/noriega/.lmstudio/bin"
# End of LM Studio CLI section


# pnpm
export PNPM_HOME="/Users/noriega/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
