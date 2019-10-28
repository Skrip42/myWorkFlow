function bgterminal() {
    WINID=$(xprop -root _NET_ACTIVE_WINDOW | grep -P -o "0x\w+" )
    xprop -f _NET_WM_NAME 8u -set _NET_WM_NAME "bgTerminal" -id $WINID 
    echo "current terminal set as bg"
}

function fgterminal() {
    WINID=$(xprop -root _NET_ACTIVE_WINDOW | grep -P -o "0x\w+" )
    xprop -f _NET_WM_NAME 8u -set _NET_WM_NAME "fgTerminal" -id $WINID 
    echo "current terminal set as fg"
}
