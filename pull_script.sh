#!/bin/bash

# Change the umask so that all files are group writable
ORIG_UMASK=`umask`
umask 0002

orig=`git log --pretty=format:%h -1`

git stash
git fetch origin
git merge origin/master
git stash pop

newhash=`git log --pretty=format:%h -1`
if [[ "$orig" != "$newhash" ]]
    then
    echo -e "Live website updated from \x02$orig\x02 to \x02$newhash\x02 by \x033$USER\x0f" > /tmp/hash-srobo
fi

# Restore the original umask
umask $ORIG_UMASK
