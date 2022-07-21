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

# Change prompt to include kubectl context
source ~/profile/kube-ps1.sh
KUBE_PS1_SYMBOL_ENABLE=false
export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(kube_ps1)\$ '

# Add Krew to the path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias c='clear'