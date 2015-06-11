#!/usr/bin/env bash

function set-jdk() {
    # setjdk from http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/
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

function pickfrom() {
    # picks random line from file
    # pickfrom /usr/share/dict/words'
    local file=$1
    [ -z "$file" ] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

function pass() {
    # generates random password from dictionary words
    # pass 4 (default)
    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the pass): $(echo $pass | tr -d ' ')"
}


function mkcd() {
    # make a directory and cd into it
    # mkcd /tmp/some_directory
    mkdir -p "$*"
    cd "$*"
}

function usage() {
    # disk usage per directory
    # usage (~/tmp)
    if [ $(uname) = "Darwin" ]; then
	if [ -n $1 ]; then
	    du -hd $1
	else
	    du -hd 1
	fi
    elif [ $(uname) = "Linux" ]; then
	if [ -n $1 ]; then
	    du -h --max-depth=1 $1
	else
	    du -h --max-depth=1
	fi
    fi
}

function command_exists() {
    # checks for existence of a command
    # command_exists ls && echo "yay!"
    type "$1" &> /dev/null ;
}

function extract() {
    if [ $# -ne 1 ]
    then
	echo "Error: No file specified."
	return 1
    fi
    if [ -f $1 ] ; then
	case $1 in
	    *.7z)      7z x $1       ;;
	    *.Z)       uncompress $1 ;;
	    *.bz2)     bunzip2 $1    ;;
	    *.deb)     ar -x $1      ;;
	    *.gz)      gunzip $1     ;;
	    *.rar)     unrar x $1    ;;
	    *.tar)     tar xvf $1    ;;
	    *.tar.bz2) tar xvjf $1   ;;
	    *.tar.gz)  tar xvzf $1   ;;
	    *.tbz2)    tar xvjf $1   ;;
	    *.tgz)     tar xvzf $1   ;;
	    *.zip)     unzip $1      ;;
	    *.war)     unzip $1      ;;
	    *.jar)     unzip $1      ;;
	    *)         echo "'$1' cannot be extracted via extract" ;;
	esac
    else
	echo "'$1' is not a valid file"
    fi
}

function extract-and-remove() {
    if [ $# -ne 1 ]
    then
	echo "Error: No file specified."
	return 1
    fi
    if [ -f $1 ] ; then
	extract $1 && rm $1
    else
	echo "'$1' is not a valid file"
    fi
}

function local-ignore() {
    # adds file or path to git exclude file
    # local-ignore private.txt
    echo "$1" >> .git/info/exclude
}

function mainfest() {
    # extracts the specified JAR/WAR file's MANIFEST file and prints it to stdout
    # manifest ~/stupid.jar

    unzip -c $1 META-INF/MANIFEST.MF
}

function tabname() {
    # renames the current terminal tab title
    printf "\e]1;$1\a"
}

function winname() {
    # renames the current terminal window title
    printf "\e]2;$1\a"
}

function pyedit() {
    # opens python module
    # pyedit kragle

    xpyc=`python -c "import sys; stdout = sys.stdout; sys.stdout = sys.stderr; import $1; stdout.write($1.__file__)"`

    if [ "$xpyc" == "" ]; then
	echo "Python module $1 not found"
	return -1

    elif [[ $xpyc == *__init__.py* ]]; then
	xpydir=`dirname $xpyc`;
	echo "$EDITOR $xpydir";
	$EDITOR "$xpydir";
    else
	echo "$EDITOR ${xpyc%.*}.py";
	$EDITOR "${xpyc%.*}.py";
    fi
}

function start-hadoop-minicluster() {
    # All ports from http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.1.5/bk_reference/content/reference_chap2.html
    export HADOOP_RESOURCE_MANAGER_PORT=8025
    export HADOOP_JOBTRACKER_PORT=10020
    export HADOOP_NAMENODE_PORT=9000

    HADOOP_VERSION=2.4.1
    local HADOOP_DIR=~/Applications/hadoop-$HADOOP_VERSION
    if [ -d $HADOOP_DIR ]; then
        local HADOOP_MINICLUSTER_JAR=$(find $HADOOP_DIR -name "hadoop-mapreduce-client-jobclient-*-tests.jar")
        local HADOOP_TEST_CLASSPATH=$(find $HADOOP_DIR -name "*-tests.jar" | grep -v $HADOOP_MINICLUSTER_JAR | paste -sd ":" -)
        if [ -f $HADOOP_MINICLUSTER_JAR ]; then
            HADOOP_CLASSPATH=$HADOOP_TEST_CLASSPATH $HADOOP_DIR/bin/hadoop jar $HADOOP_MINICLUSTER_JAR minicluster -rmport $HADOOP_RESOURCE_MANAGER_PORT -jhsport $HADOOP_JOBTRACKER_PORT -nnport $HADOOP_NAMENODE_PORT
        else
            echo "Unable to find minicluster jar for hadoop version $HADOOP_VERSION"
        fi
    else
        echo "Unable to find hadoop directory for hadoop version $HADOOP_VERSION"
    fi
}
