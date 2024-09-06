export EDITOR=vi


function git_changed(){
    local lines files
    lines=$(git status --porcelain) || return 1
    lines=$(awk '!match($1, "D"){print $1, $2}' <<<"$lines") || return 1
    files=$(awk 'match($1, "[AM]"){print $2}' <<<"$lines") || return 1
    echo "$files"
}


pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH=$PATH:$1
           else
              PATH=$1:$PATH
           fi
        fi
}


function set_title(){
	local orig=$PS1
	title="\[\e]2;$@\a\]"
	PS1="${orig}${title}"
	export MYTITLE="$@"
}
export -f set_title

function rebash(){
	source ~/.bashrc
}
export -f rebash

function pycharm(){
	nohup ~/pycharm/bin/pycharm >~/pycharm-nohup.out 2>&1 &
}
export -f pycharm

alias glo="git log --pretty=oneline --abbrev-commit"

# Portable git prompt.
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]\n$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

pathmunge $HOME/.local/bin

