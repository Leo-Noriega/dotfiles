# fzf into a directory
cc() {
    dir=$(fd -td -H . $HOME -E Library/ | fzf -i --border --padding=1 --height=30% --layout=reverse)
    if [ -z "$dir" ]; then
        gum style \
            --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
            'No directory selected'
        return 1
    fi
    cd "$dir" && gum style \
        --foreground "#76946A" --border rounded --align center --bold --padding "0.1 0.1" \
        "Now in: $(pwd)"
}

# fzf into a directory where you at
c() {
    dir=$(pwd | fd -td -d1 -H | fzf -i --border --padding=1 --height=30% --layout=reverse)
    if [ -z "$dir" ]; then
        gum style \
            --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
            'No directory selected'
        return 1
    fi
    cd "$dir" && gum style \
        --foreground "#76946A" --border rounded --align center --bold --padding "0.1 0.1" \
        "Now in: $(pwd)" }

# fzf into a directory and open it (choose)
opd() {
    dir=$(fd -td -H . $HOME -E Library/ | fzf -i --border --padding=1 --height=30% --layout=reverse)
    if [ -z "$dir" ]; then
        gum style \
            --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
            'No directory selected'
        return 1
    fi
    opt=$(gum choose --header="What are you gonna do with the directory?" "nvim" "code" "finder" "zip")
    case $opt in
        nvim)
            cd "$dir" && nvim "$dir"
            ;;
        code)
            code "$dir"
            ;;
        finder)
            open "$dir"
            ;;
        zip)
            zip_name="$(basename "$dir").zip"
            zip -r "$zip_name" "$dir" > /dev/null
            if [ $? -eq 0 ]; then
                gum style \
                    --foreground "#76946A" --border rounded --align center --bold --padding "0.1 0.1" \
                    "Zipped: $zip_name"
            else
                gum style \
                    --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
                    "Failed to create zip file"
            fi
            ;;
        *)
            gum style \
                --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
                'No option selected'
            return 1
            ;;
    esac
}

# fzf into a file and open it (choose)
opf() {
    file=$(fd -t f -H . $HOME -E Library/ | fzf -i --border --padding=1 --height=30% --layout=reverse)
    if [ -z "$file" ]; then
        gum style \
            --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
            'No file selected'
        return 1
    fi
    opt=$(gum choose --header="What are you gonna do with the file?" "nvim" "cat" "copy")
    case $opt in
        nvim)
            nvim "$file"
            ;;
        cat)
            cat "$file"
            ;;
        copy)
            cat "$file" | pbcopy
            gum style \
                --foreground "#76946A" --border rounded --align center --bold --padding "0.1 0.1" \
                "Copied: $file"
            ;;
        *)
            gum style \
                --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
                'No option selected'
            return 1
            ;;
    esac
}

share() {
    local dir="$HOME/Projects/Personal/docker/FileBrowser"
    local port=1000
    local started_orbstack=0

    if [ ! -d "$dir" ]; then
        gum style \
            --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" \
            "❌ Directory not found: $dir"
        return 1
    fi

    # Iniciar OrbStack si no está activo
    if ! pgrep -x "OrbStack" >/dev/null; then
        gum style \
            --foreground "#DCA561" --border rounded --align center --bold --padding "0.1 0.1" \
            "Launching OrbStack in background..."
        open -g -a OrbStack
        sleep 5
        started_orbstack=1
    fi

    cd "$dir"

    gum style \
        --foreground "#7E9CD8" --border rounded --align center --bold --padding "0.1 0.1" \
        "Checking FileBrowser container..."
    if ! docker compose ps | grep -q filebrowser; then
        gum style \
            --foreground "#DCA561" --border rounded --align center --bold --padding "0.1 0.1" \
            "Starting FileBrowser..."
        docker compose up -d
        sleep 3
    fi

    gum style \
        --foreground "#76946A" --border rounded --align center --bold --padding "0.1 0.1" \
        "Opening TunnelMole on port $port..."

    # Capturar Ctrl+C para limpiar
    trap 'gum style --foreground "#AF1B01" --border rounded --align center --bold --padding "0.1 0.1" "🛑 Shutting down..."; kill $tm_pid 2>/dev/null; [ $started_orbstack -eq 1 ] && osascript -e "quit app \"OrbStack\"" >/dev/null 2>&1; exit 0' INT

    # Lanzar TunnelMole en background
    tunnelmole $port &
    tm_pid=$!

    wait $tm_pid
}

