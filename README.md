Git Big Lfs Hook
================
Hook for git detecting files not tracked by lfs that are too big before commit.

Prints `git lfs track LIST_OFF_FILES_NOT_TRACKED` for a quick .gitattributes update

Configuration
-------------

You can specify max size in bytes
`export GITBIG_MAX_SIZE=1000000` here is 1M Configuration

To activate verbose
`export GITBIG_DEBUG=true`