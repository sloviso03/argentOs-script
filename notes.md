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
    - sudo apt install fzf

    - nano ~/.bashrc
        source /usr/share/doc/fzf/examples/key-bindings.bash

    - source ~/.bashrc

