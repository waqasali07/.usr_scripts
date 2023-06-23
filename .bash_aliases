#! /bin/bash

export QTCSH=/home/dev/Qt/Tools/QtCreator/bin/qtcreator.sh

#git
alias gst="git status"
alias gbr="git branch"
alias gcm="git checkout main"
alias gmm="git merge main"
alias gpul="git pull"
alias gsub="git submodule update --init --recursive"

function gch(){     #git checkout <branch name>  or branch name set in the variable BRANCH
if [[ ! $1 ]] && [ ! ${BRANCH} ]
then 
	echo "Error! No branch name provided."
		return
fi

if [ ! $1 ]
then
	git checkout ${BRANCH}
else
	git checkout $*
fi

}

function gcl()  #git clone <link>
{
git clone $1
}

function gcom(){    #git commit all      gcom msg 
git commit -am "$*"
}

function gmb(){        #git merge branch <arg>
git merge branch $1
}

function gpus(){       #git push
git push $*
}

function gre(){   # git resotre <arg>
git restore $*
}

function gpa(){        #git commit and git push combined   gpa "<msg>" or gpa msg
gcom "$*"
git push
}

function gsu(){        #git set upstream to branch  gsu <branch>
gpus --set-upstream origin $*
}

function qtc(){			#start qtcreator <args>
${QTCSH} $*
}

#general purpose

alias cls="clear"     #clear screen
alias lst="grep alias /home/dev/.bash_aliases && grep function /home/dev/.bash_aliases"   #list all of the aliases and functions
alias lug="apt list --upgradable"      
alias rel=". ~/.bashrc"
alias edt="code ~/.bash_aliases"

function sysup(){
sudo apt update
sudo apt -y upgrade
}

function rmd(){          #remove directory and its contents
rm -rdf "$*"
}

function mcd(){        #make and cd into the directory
echo Creating directory named "$*"
mkdir "$*"
cd "$*"
}

function up(){    #go up 1 or more directories
local j
if [ ! $1 ]
then
	j=1
else
	j=$1
fi

for((i=0;i<j;i++))
do
	cd ..
done
}

function prv(){    #print env variable
v=${1^^}
echo ${!v}
}

function lpkg(){    #find and list installed packages e.g. lpkg libboost
	apt list --installed | grep $* 
}

#work
function gfr()
{
	gcl "https://lincolnelectric-rnd@dev.azure.com/lincolnelectric-rnd/Cleveland-Firmware/_git/frontier_gui"
	cd frontier_gui
	gch 338-port-to-qt6
	gsub
}