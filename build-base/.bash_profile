export PATH=$HOME/.local/bin:$PATH
source ~/.git-prompt.sh

#note: quoting is important here; keep the single quotes around PS1 value and double quotes inside for the git formatting
############GREEN__________USER_GREY______@_GREEN_________HOST_:_CYAN______PWD_YELLOW________GIT BRANCH__________CLEAR_______DOLLAR
export PS1='\[\033[00;32m\]\u\[\033[0;37m\]@\[\033[00;32m\]\h:\[\033[0;36m\]\w\[\033[01;33m\] $(__git_ps1 "(%s)")\[\033[00m\] $ '