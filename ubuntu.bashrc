export EDITOR=vi

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
	nohup ~/pycharm-community-2020.2.3/bin/pycharm.sh >~/pycharm-nohup.out 2>&1 &
}
export -f pycharm

# Portable git prompt.
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]\n$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

pathmunge $HOME/.local/bin

