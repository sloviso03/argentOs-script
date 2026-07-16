# Notes: Next steps after install
# Connect github account into terminal
    - Generate keygen
        ssh-keygen -t ed25519 -C "your_email@example.com"

    - Copy content of the keygen
        cat ~/.ssh/id_ed25519.pub

    - Paste content into https://github.com/settings/keys

    - Setup your account
        git config --global user.email "you@example.com"
        git config --global user.name "Your Name"

    - Test your connection
        ssh -T git@github.com


# Install fzf with CTRL+R keybind (argentOs already has it installed)
    - sudo dnf install fzf

    - nano ~/.bashrc
    - Write this at the end -> '  source /usr/share/fzf/shell/key-bindings.bash  '
    - Add alias for clear -> '  alias fzf-clear='history -c && history -w && clear'  '
    - Reload with source ~/.bashrc
