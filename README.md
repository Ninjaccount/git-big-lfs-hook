Git Big Lfs Hook
================
Prevent commit if a file is too big and not tracked by lfs.

Prints all big files and their sizes.

Also prints `git lfs track LIST_OFF_FILES_NOT_TRACKED_TOO_BIG` for a quick .gitattributes update

Installation
-------------
Save or link `pre-commit.sh` as `.git/hooks/pre-commit`

Configuration
-------------
You can specify max size in bytes (default is 1M)

`export GITBIG_MAX_SIZE=50000` here is 500k Configuration

To activate debug

`export GITBIG_DEBUG=true`
