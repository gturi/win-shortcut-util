# Windows shortcut util

Utility to manage windows shortcuts through terminal.


## Install

Source `git-bash-shortcut-utils.sh` into your `.bashrc`.

You can also run `installer-for-git-bash.sh` to quickly achieve the same.

The installer relies on the following function:

```bash
function sourceIfExists() { 
  if [ -f "$1" ]; then 
    . "$1" 
  fi 
}
```

Add it to your bashrc before running it.


## Usage

The script will add support windows shortcuts (`.lnk` files) to your git bash terminal sessions, by leveraging two powershell scripts.

The builtin `cd` will be redefined, and will use a custom behaviour when a windows shortcut is provided.

Moreover, you can use `create-shortcut $shortcutTargetDir $shortcutStorePath` function to create a new shortcut:
- shortcutTargetDir is the absolute path to the directory you want to create a shortcut for
- shortcutStorePath is the absolute path to where you want to store your shortcut
