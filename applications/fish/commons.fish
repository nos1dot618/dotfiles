function log
    set -l level $argv[1]
    set -l color $argv[2]
    set -l message (string join " " $argv[3..-1])

    printf "["
    set_color $color
    printf $level
    set_color normal
    printf "] %s\n" $message
end

function log_info
    log INFO blue $argv
end

function log_note
    log NOTE brblack $argv
end

function log_warn
    log WARN yellow $argv
end

function log_error
    log ERROR red $argv
end

function log_debug
    log DEBUG cyan $argv
end

function log_fatal
    log FATAL red $argv
    exit 1
end
