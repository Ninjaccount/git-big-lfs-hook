Git Big Lfs Hook
================
Prevent commit if a file is too big and not tracked by lfs.

Prints all big files and their sizes.

Also prints `git lfs track LIST_OFF_FILES_NOT_TRACKED_TOO_BIG` for a quick .gitattributes update

Installation
-------------
Save or link `pre-commit.sh` as `.git/hooks/pre-commit`

Usage
-------------

1. `git commit ... #Hook won't let you commit if lfs doesn't track files above GITBIG_MAX_SIZE. You can also commit without message for testing purpose`
2. `git lfs track ... #Add tracks printed by the hook`
3. `git reset ... #Reset the newly tracked files in order to let lfs reindex them` or `git reset HEAD^ #if the commit was performed`
4. `git add ... #Reindex the files`
5. `git commit ... #Now hook will let you commit`

Configuration
-------------
You can specify max size in bytes (default is 1M)

`export GITBIG_MAX_SIZE=500000` here is 500k Configuration

To activate debug

`export GITBIG_DEBUG=true`
