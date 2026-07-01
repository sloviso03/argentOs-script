# Notes: Next steps after install
# Connect github account into terminal
    - Generate keygen
        ssh-keygen -t ed25519 -C "your_email@example.com"

    - Copy content of the keygen
        cat ~/.ssh/id_ed25519.pub

    - Paste content into https://github.com/settings/keys

    - Test your connection
        ssh -T git@github.com
