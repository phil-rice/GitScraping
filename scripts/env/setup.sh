#!/usr/bin/env bash

function commonHelp(){
  echo "Usage: setup.sh  (--makeBin) (--envVariables) (--help) (--chmod) (--dos2unix)"
  echo "   Remember that if you want to change environment variables, this must be 'source'ed"
}
if [  $# -lt 1 ] ; then
   commonHelp
   exit
fi

me=setup.sh
function installationGuide(){
echo "
To run on your laptop
    Download the git repo

    source scripts/env/$me --envVariables

    Start a new shell

    Check it works by
       '<TBD>'


Troubleshooting:
    When running $me remember that $me modifies environment variables. It should normally be executed by 'source'
    From the root of this project 'source scripts/env/$me (options)' is the usual command
"
   exit
}

function importInstallHelp(){
#!/usr/bin/env bash
    commonHelp
    echo "   --help                           # display this"
    echo "   --firstTime                      # partially sets up import (enough to run, but not enough to do serious things) and then displays 'getting going' instructions"
    echo "   --installationGuide              # displays instructions on how to get started"
    echo "   --makeBin                        # sets up the symbolic links and updates the path"
    echo "   --chmod                          #  makes sure the SCRIPT_DIR has 'chmod u+x' on all files"
    echo "   --envVariables                   # initialises the environment variablse and updates the path ASSUMPTION: executing in root folder"
    echo "   --dos2unix                       # runs over the script directories and subdirectories with dos2unix"
    exit
}

function optionallyChangeDirectoryToimport(){
   if [ "$import_git_dir" != "" ]; then
      pushd $import_git_dir
   else
      pushd .
   fi
}

function checkPwdHasScriptsDirectory(){
   if [ ! -d "scripts" ]; then
       echo "importInstall $1 must be run in a folder with a scripts subdirectory. pwd is `pwd`"
       exit 2
    fi
 }

function optionalMakeBin(){
   optionallyChangeDirectoryToimport > /dev/null
      if [ -d bin ] ; then
         popd > /dev/null
         return
      fi
   popd > /dev/null
   makeBin
}

function makeBin(){
    optionallyChangeDirectoryToimport > /dev/null
        echo "makeBin `pwd` (making symbolic links to scripts and adding that directory to the path)"
        checkPwdHasScriptsDirectory --makeBin
        rm -rf bin
        mkdir bin
        cd bin
        bindir=`pwd`
        find ../scripts -maxdepth 3 -type f ! -name "*.*" -exec ln -s {}  \;
        find ../scripts -maxdepth 3 -type f  -name "*.sh" -exec ln -s {}  \;
        chmod u+x ../scripts
        setPath $bindir
    popd > /dev/null
    }


function envVariables(){
     optionallyChangeDirectoryToimport > /dev/null
        echo "setting envVariables and current directory is `pwd` (if not running using source, this will do nothing)"
        checkPwdHasScriptsDirectory --envVariables
        tempsh=`mktemp`
        export pwd=`pwd`
        export whoami=`whoami`
        cat $pwd/scripts/env/env.txt | awk '{ print "export " $1  "=" $2 "" }' > $tempsh
        source $tempsh
        rm $tempsh
        export import_LOG_INDENT='...'
        setPath `pwd`/bin
    popd > /dev/null
}

function setPath(){
   bindir=$1
   if [[ $PATH != *"$bindir"* ]]; then
       export PATH=$bindir:$PATH
   fi
}

function checkEnv(){
   var=$1
  if [ "${!1}" = "" ]; then
     echo "$me needs $1 set"
     exit 2
  fi
}


function dos2u(){
  echo "dos2unix on files in $SCRIPT_DIR"
  dpkg -s dos2unix 2>/dev/null >/dev/null
  if [ $? != 0 ]; then
     echo "Please install dos2unix"
     exit 2
  fi
  checkEnv SCRIPT_DIR
  find $SCRIPT_DIR -type f -print0 | xargs -r  -0 dos2unix 2> /dev/null
}

ORIGINAL=( "$@" )
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
       --help)              importInstallHelp; exit;;
       --installationGuide) displayInstallationGuide="true" ; shift;;
       --firstTime)         bin="true"; env="true";chmod="true"; first="true"; makeScripts="true"; shift;;
       --makeBin)           bin="true"; shift;;
       --envVariables)      env="true"; shift;;
       --chmod)             chmod="true"; shift;;
       --dos2unix)          dos=true; shift;;
       *)                   POSITIONAL+=( "$1" ); shift;;
    esac
done

if [ ${#POSITIONAL[@]} -gt 0 ]; then
   echo "Did not understand parameters ${POSITIONAL}";
   exit 2;
fi

case "$bin" in
   "true")  makeBin;;
   "maybe") optionalMakeBin;;
   *) ;;
esac

if [ "$env" ]; then
   envVariables
fi

if [ "$chmod" != "" ]; then
   optionallyChangeDirectoryToimport > /dev/null
       checkPwdHasScriptsDirectory  --chmod
       echo "executing chmod -R u+x $SCRIPT_DIR"
       chmod -R u+x $SCRIPT_DIR
   popd > /dev/null
fi

if [ "$dos" ]; then
    dos2u
fi

if [ "$displayInstallationGuide" != "" ]; then
  installationGuide
fi
