function svim() {
    SERVERCOUNT=$(vim --serverlist | wc -l)
    vim --servername editor$(( $SERVERCOUNT + 1 )) $1
}

function cvim() {
    SERVERCOUNT=$(vim --serverlist | wc -l)
    echo $SERVERCOUNT
    if [ "$SERVERCOUNT" -eq 0 ]; then
        svim $1
    else
        vim --servername editor$($SERVERCOUNT) --remote $1
    fi
}

function vfzf() {
    cvim $(fzf)
}

