# Git branch in prompt.

function parse_git_dirty {
 [[ -n "$(git status -s 2> /dev/null)" ]] && echo -e '\033[1;31m'
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ $(parse_git_dirty)(\1)/"
}

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Git command aliases

alias gaa='git add -A'
alias gcm='git commit -m'
alias gcma='git commit -a -m'
alias gwait='git reset HEAD' # Unstages everything.
alias gl='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gundo='git reset --soft HEAD^' # Undoes the last commit and moves the files in the commit to staging.
alias gco='git checkout'
alias gpusho="git push origin ${parse_git_branch}"
alias gpullo="git pull --rebase origin ${parse_git_branch}"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
