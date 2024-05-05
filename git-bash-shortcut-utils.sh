#!/bin/bash

function pathToWindowsStyle {
  local SUB='/'
  if [[ "$1" == *"$SUB"* ]]; then
    cygpath.exe -w "$1"
  else
    echo "$1"
  fi
}

function pathToUnixStyle {
  local SUB='/'
  if [[ "$1" == *"$SUB"* ]]; then
    echo "$1"
  else
    cygpath.exe -u "$1"
  fi
}

function isWindowsShortcut {
  if [ ".lnk" = "${1:(-4)}" ] && [ -f "$1" ] ; then
    true
  else
    false
  fi
}

function cd {
  if isWindowsShortcut "$1" ; then
    local path
    path="$(pathToWindowsStyle "$1")"
    local getShortcutTarget
    getShortcutTarget="$(pathToWindowsStyle "$(dirname "${BASH_SOURCE[0]}")/get-shortcut-target.ps1")"
    local shortcutTarget
    shortcutTarget="$(powershell -c "$getShortcutTarget $path")"
    local shortcutTargetUnixStyle
    shortcutTargetUnixStyle="$(pathToUnixStyle "$shortcutTarget")"
    builtin cd "$shortcutTargetUnixStyle"
  elif [[ -z "$1" ]] ; then
    builtin cd
  else
    builtin cd "$1"
  fi
}

function create-shortcut {
  local TARGET_DIR
  TARGET_DIR="$(pathToWindowsStyle "$1")"
  local BOOKMARK
  BOOKMARK="$(pathToWindowsStyle "$2")"
  local createShortcutTarget
  createShortcutTarget="$(pathToWindowsStyle "$(dirname "${BASH_SOURCE[0]}")/create-shortcut.ps1")"
  
  powershell -c "$createShortcutTarget $TARGET_DIR $BOOKMARK"
}

export -f cd create-shortcut
