#dir=dirname $0

# readoutput=$(readlink -f "$0")
# dir=$(dirname $readoutput)
# echo $readoutput
# echo $dir

# z changes directories without needing to specify the start of the path
. ~/profile/z.sh

. ~/profile/helm
. ~/profile/kubectl

alias k='kubectl'
complete -F __start_kubectl k

alias gs='git status'

# Change to Windows style tab completion (https://superuser.com/questions/59175/is-there-a-way-to-make-bash-more-tab-friendly)
bind '"\t":menu-complete'
bind '"\e[Z":menu-complete-backward'