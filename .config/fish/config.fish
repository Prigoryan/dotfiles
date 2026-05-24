if status is-interactive
    # Commands to run in interactive sessions can go here

    fzf --fish | source

    set -gx fifc_editor micro
    set -gx fifc_fd_opts --hidden
    
    set -gx fish_greeting
    
    bind ctrl-h backward-kill-path-component
    bind ctrl-u kill-whole-line
end
