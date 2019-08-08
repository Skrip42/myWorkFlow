#TODO fix it! make the path relative
export ZSH="/home/skrip/.oh-my-zsh"

#my favorite theme
ZSH_THEME="af-magic" 
#fix promt on mercarial 
PROMPT='$FG[237]${(l.COLUMNS..-.)}%{$reset_color%}
$FG[032]%~\
    $(git_prompt_info)$(branch_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '

#plugins
plugins=(
    git
    branch
    npm
    composer
    vi-mode
    sudo
    docker
    docker-compose
    extract
)
#enable ohMyZsh engin
source $ZSH/oh-my-zsh.sh

#plugin fzf has problem on opensuse.... its fix this
export FZF_CTRL_R_OPTS='--sort --exact'
source ~/myWorkFlow/zshskript/fzf-completion.zsh
source ~/myWorkFlow/zshskript/fzf-key-bingings.zsh

#my litle plugin for server vim
source ~/myWorkFlow/zshskript/svim.zsh

#start tmux only for local session
if [[ ! -n $SSH_CONNECTION ]]; then
    if [ "$TMUX" = "" ]; then tmux; fi
fi

# enable this for history beginning search
#bindkey "^[[5~" history-beginning-search-backward # pg up
#bindkey "^[[6~" history-beginning-search-forward # pg down

#languige
export LANG=en_US.UTF-8
#term color
export TERM='xterm-256color'
#set vim default editor
export EDITOR='vim'
#remove ksshaskpass
unset SSH_ASKPASS
unset GIT_ASKPASS
