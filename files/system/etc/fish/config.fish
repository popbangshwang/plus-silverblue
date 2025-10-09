if status is-interactive
    starship init fish | source

    # Alias ls commands to use lsd with icons
    alias ls 'lsd --icon=auto'
    alias ll 'lsd -l --icon=auto'
    alias la 'lsd -la --icon=auto'
end
