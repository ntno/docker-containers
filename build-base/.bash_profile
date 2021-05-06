export PATH=$HOME/.local/bin:$PATH
source ~/.git-prompt.sh
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1) \$\[\033[0m\033[0;32m\] \[\033[0m\] '