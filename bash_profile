#!/usr/bin/env bash

[ -z "$PS1" ] && return # If not running interactively, don't do anything

source $HOME/.bash_functions

set -o emacs    # emacs style readline
unset MAILCHECK # Don't check mail when opening terminal.

shopt -s checkwinsize # Update the window size env variables after every command
shopt -s cdspell # Fix minor spelling errors when using CD

export BASH_PROFILE_LOADED=1
export GIT_PROMPT_THEME='Default'
export GHC_DOT_APP="/Applications/ghc-7.8.4.app"
export HISTCONTROL=ignoreboth # Ignore lines starting with spaces and duplicates in the history file
export HISTIGNORE='fg:exit:clear:history' # Ignore these commands in history
export JAVA_HOME="$(/usr/libexec/java_home)"
export LESS='--RAW-CONTROL-CHARS --quiet' # Get color support for 'less'
export PAGER='less'
export PATH=~/bin:~/code/stash/NEBULA/wrapper:/usr/local/bin:~/.cabal/bin:${GHC_DOT_APP}/Contents/bin:$PATH:/usr/local/sbin
export VISUAL='vim'

alias bup='brew update && brew upgrade --all'
alias canary="open -a google\ chrome\ canary"
alias chrome="open -a google\ chrome"
alias di='eval $(boot2docker shellinit)'
alias dip="boot2docker ip"
alias dsclean='find . -type f -name .DS_Store -delete'
alias firefox="open -a firefox"
alias flush='dscacheutil -flushcache'
alias ga='git add'
alias gall='git add .'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gclean='find . -type d -name build | xargs rm -rf'
alias gco='git checkout'
alias gd='git diff "$@" | vim -R -'
alias gdel='git branch -D'
alias gdv='git diff -w "$@" | vim -R -'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gnew="git log HEAD@{1}..HEAD@{0}" # Show commits since last pull
alias gp='git push'
alias gpo='git push origin'
alias gpr='git pull --rebase'
alias gs='git status'
alias gup='git fetch --all -p && git rebase'
alias http='python -m SimpleHTTPServer'
alias ips='ifconfig | grep "inet " | awk "{print \$2}"'
alias pop="popd"
alias preview="open -a preview"
alias pubip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"
alias push="pushd"
alias pushhere="pushd \`pwd\`"
alias safari="open -a safari"
alias xmltidy='tidy -i -xml -m -q'

[ -x /usr/bin/mdfind ] && alias locate='/usr/bin/mdfind'
[ -x /usr/local/bin/gdircolors ] && alias dircolors='/usr/local/bin/gdircolors'
[ -x /usr/local/bin/gls ] && alias ls='/usr/local/bin/gls --color=auto'
[ -x /usr/local/bin/lesspipe ] && eval "$(/usr/local/bin/lesspipe)"
[ -x /usr/local/bin/lesspipe.sh ] && eval "$(/usr/local/bin/lesspipe.sh)"

[[ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]] && source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
[[ -f /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -f ~/.dircolors-solarized/dircolors.256dark ]] && eval "$(dircolors ~/.dircolors-solarized/dircolors.256dark)"
[[ -f ~/.less_termcap ]] && source ~/.less_termcap # Use colors for less, man, etc.

# setjdk from http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/
function set-jdk() {
    if [ $# -ne 0 ]; then
        remove-from-path '/System/Library/Frameworks/JavaVM.framework/Home/bin'
        if [ -n "${JAVA_HOME+x}" ]; then
            remove-from-path $JAVA_HOME
        fi
        export JAVA_HOME=`/usr/libexec/java_home -v $@`
        export PATH=$JAVA_HOME/bin:$PATH
    fi
}

function remove-from-path() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function link-gradle() {
  # Wrapper script
  ln -s $HOME/code/stash/NEBULA/wrapper/gradlew gradlew
  # Directory
  ln -s $HOME/code/stash/NEBULA/wrapper/gradle gradle
}

function cd-to-finder() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}
