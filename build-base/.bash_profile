export PATH=$HOME/.local/bin:$PATH
source ~/.git-prompt.sh
export PS1='\[\033[38;5;14m\]\u@\h:\[\033[38;5;10m\]\w\[\033[38;5;11m\]$(__git_ps1) \\$ \[\033[0m\]'