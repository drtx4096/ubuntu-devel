export EDITOR=vi

function set_title(){
	local orig=$PS1
	title="\[\e]2;$@\a\]"
	PS1="${orig}${title}"
}
export -f set_title

function rebash(){
	source ~/.bashrc
}
export -f rebash

