#!/bin/sh -e
CLOUD9PATH=/Users/gord/projects/cloud9
# lets check if we have the submodules initialized
cd `dirname $0`
cd ..
if [ ! -e support/ace/LICENSE ]; then
    echo "--------------------------- Please wait, initializing submodules for first launch ------------------------"
    git submodule update --init --recursive
    echo "--------------------------- Submodules installed ------------------------"
fi
$CLOUD9PATH/bin/install_npm_dependencies.sh

case `uname -a` in
Linux*x86_64*)  echo "Linux 64 bit"   
    $CLOUD9PATH/support/node-builds-v4/node-linux64 $CLOUD9PATH/bin/cloud9.js "$@" -a x-www-browser
    ;;

Linux*i686*)  echo "Linux 32 bit"   
    $CLOUD9PATH/support/node-builds-v4/node-linux32 $CLOUD9PATH/bin/cloud9.js "$@" -a x-www-browser
    ;;
    
Darwin*)  echo  "OSX"
    $CLOUD9PATH/support/node-builds-v4/node-darwin $CLOUD9PATH/bin/cloud9.js "$@" -a open
    ;;

CYGWIN*)  echo  "Cygwin"
    $CLOUD9PATH/support/node-builds-v4/node-cygwin.exe $CLOUD9PATH/bin/cloud9.js "$@" -a "cmd /c start"
    ;;

MING*)  echo  "MingW"
    $CLOUD9PATH/support/node-builds-v4/node-cygwin.exe $CLOUD9PATH/bin/cloud9.js "$@" -a "cmd /c start"
    ;;    

SunOS*)  echo  "Solaris"
    $CLOUD9PATH/support/node-builds-v4/node-sunos $CLOUD9PATH/bin/cloud9.js "$@"
    ;;


*) echo "Unknown OS"
   ;;
esac
