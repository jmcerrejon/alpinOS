alias comm='lbu commit -d'
alias edit_rc='nano ~/.bashrc && source ~/.bashrc'
alias edit_al='nano ~/.bash_aliases && source ~/.bash_aliases'
# apk
alias aa='apk add $1'
alias as="apk search -v '{$1}*'"
# common
# Very useful ncdu command
alias du='sudo du -shc $1*'
alias duh='du -sch .[!.]* * |sort -h'
alias ll='ls -la'
alias rmr='rm -rf $1'
alias ..='cd ..'
alias ...='cd ../..'
alias info='uname -a && '