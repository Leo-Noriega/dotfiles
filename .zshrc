# ==== GIT ====
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }

setopt prompt_subst

# ==== EXPORTS ====
export PATH="$HOME/.config/emacs/bin:$PATH"
export PROMPT='%B%F{124}%t%f%b - %B%F{31}%n%f%b:%~ | %B%F{208}${vcs_info_msg_0_} %B%F{white}'
export EDITOR="emacsclient -c"
export TERMINAL="alacritty"

# ==== ALIASES ====
alias et="emacsclient -t"
alias pp="php bin/console"
# ==== FUNCTIONS ====

# fzf into a directory
cc() {
    dir=$(fd -td -H . $HOME -E Library/ | fzf -i --border --padding=1 --height=30% --layout=reverse)
    if [ -z "$dir" ]; then
        gum style \
            --foreground 31 --border rounded --align center --bold --padding "0.1 0.1" \
            'No directory selected'
    fi
    cd "$dir"
}

# fzf into a file
cf() {
    file=$(fd -t f -H . $HOME -E Library/ | fzf)
    if [ -z "$file" ]; then
        gum style \
            --foreground 31 --border rounded --align center --bold --padding "0.1 0.1" \
            'No file selected'
    fi
    # gum choose --header="What are you gonna do with the file?" "emacs" "read" "finder"
    $EDITOR "$file"
}
