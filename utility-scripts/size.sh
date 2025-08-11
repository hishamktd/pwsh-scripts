size() {
    local path="./"
    local unit="mb"
    local list=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -p) path="$2"; shift 2 ;;
            -u) unit="$2"; shift 2 ;;
            -l) list=true; shift ;;
            *) echo "Unknown option: $1"; return 1 ;;
        esac
    done

    # Resolve absolute path
    if [ ! -e "$path" ]; then
        echo "Path not found: $path"
        return 1
    fi

    # Unit conversion factor
    local factor=1 suffix="Bytes"
    case "$unit" in
        bytes) factor=1; suffix="Bytes" ;;
        kb)    factor=1024; suffix="KB" ;;
        mb)    factor=$((1024*1024)); suffix="MB" ;;
        gb)    factor=$((1024*1024*1024)); suffix="GB" ;;
        tb)    factor=$((1024*1024*1024*1024)); suffix="TB" ;;
        *) echo "Invalid unit: $unit"; return 1 ;;
    esac

    if [ "$list" = true ]; then
        # List direct children
        echo -e "Name\tType\tSize"
        for item in "$path"/*; do
            [ -e "$item" ] || continue
            if [ -d "$item" ]; then
                size_bytes=$(find "$item" -type f -printf "%s\n" 2>/dev/null | awk '{sum+=$1} END {print sum}')
                type="Folder"
            else
                size_bytes=$(stat -c%s "$item" 2>/dev/null)
                type="File"
            fi
            size_human=$(awk -v s="$size_bytes" -v f="$factor" -v suf="$suffix" 'BEGIN {printf "%.2f %s", s/f, suf}')
            echo -e "$(basename "$item")\t$type\t$size_human"
        done | column -t
    else
        # Total size mode
        total_bytes=$(find "$path" -type f -printf "%s\n" 2>/dev/null | awk '{sum+=$1} END {print sum}')
        if [ -z "$total_bytes" ]; then
            echo "No files found in path: $path"
            return
        fi
        awk -v s="$total_bytes" -v f="$factor" -v suf="$suffix" 'BEGIN {printf "%.2f %s\n", s/f, suf}'
    fi
}
