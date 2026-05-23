if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # fzf --fish | source

    # fzf_key_bindings

    

    set -gx fifc_editor micro
    set -gx fifc_fd_opts --hidden
    set -gx _fifc_custom_fzf_opts '--bind=up:up,down:down'
    
    set -gx fish_greeting
    
    bind ctrl-h backward-kill-path-component
end
