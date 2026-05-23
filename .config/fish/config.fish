if status is-interactive
    # Commands to run in interactive sessions can go here
    fzf --fish | source

    bind ctrl-h backward-kill-path-component
end
