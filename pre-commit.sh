#!/bin/bash

function logDebug(){
  if [ "$GITBIG_DEBUG" = true ]; then
    echo "$1"
  fi
}

function logDebugArray(){
  if [ "$GITBIG_DEBUG" = true ]; then
    printf '%s\n' "$1"
  fi
}




MAX_FILE_SIZE=$GITBIG_MAX_SIZE
if [ -z $GITBIG_MAX_SIZE ]; then
  MAX_FILE_SIZE=1000000
fi

MODIFIED_FILES_IN_LFS=$(git lfs status --porcelain | sed -r 's/([A-Z].\s)(.*)(\s[0-9]+)/\2/')
ALL_MODIFIED_FILES=$(git diff --cached --name-status | cut -f 2 | xargs -d "\n" stat -c "%n")
CONCAT=("${MODIFIED_FILES_IN_LFS[@]}" "${ALL_MODIFIED_FILES[@]}")
MODIFIED_FILES_NOT_IN_LFS=$(printf '%s\n' "${CONCAT[@]}" | sort | uniq -u)

logDebug MODIFIED_FILES_NOT_IN_LFS
logDebug $MODIFIED_FILES_NOT_IN_LFS

MODIFIED_FILES_NOT_IN_LFS_WITH_SIZE=$(printf '%s\n' "${MODIFIED_FILES_NOT_IN_LFS[@]}" |xargs -d "\n" stat -c "%n___delimiter___%s")

logDebug MODIFIED_FILES_NOT_IN_LFS_WITH_SIZE
logDebugArray "${MODIFIED_FILES_NOT_IN_LFS_WITH_SIZE[@]}"

# required to handle space in filenames
OIFS="$IFS"
IFS=$'\n'
TOO_BIG_FILE_FOUND=false
TOO_BIG_FILES=()
for FILE in $MODIFIED_FILES_NOT_IN_LFS_WITH_SIZE
do
  
  NAME=${FILE%___delimiter___*}
  SIZE=${FILE#*___delimiter___}
  logDebug "Debug: file|size: ${NAME}|${SIZE} "

  if [ "$SIZE" -gt "$MAX_FILE_SIZE" ]; then
    TOO_BIG_FILE_FOUND=true
    TOO_BIG_FILES+=("$NAME")
    echo "FILE IS TOO BIG $NAME (size $SIZE)"
  fi

done

IFS="$OIFS"

if [ "$TOO_BIG_FILE_FOUND" = true ]; then
  echo "COMMIT REFUSED, TOO BIG FILE FOUND"
  echo "git lfs track " $(printf '"%s" ' "${TOO_BIG_FILES[@]}")
  exit 1
fi

exit 1