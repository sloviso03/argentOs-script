if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec sway
fi
