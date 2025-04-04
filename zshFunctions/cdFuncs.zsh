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
        --foreground "#658594" --border rounded --align center --bold --padding "0.1 0.1" \
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
        --foreground "#658594" --border rounded --align center --bold --padding "0.1 0.1" \
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
                    --foreground "#658594" --border rounded --align center --bold --padding "0.1 0.1" \
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
                --foreground "#658594" --border rounded --align center --bold --padding "0.1 0.1" \
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
