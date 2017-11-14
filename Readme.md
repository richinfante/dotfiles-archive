# Dotfiles
These are the dotfiles I use installed on _most_ of my machines.
They provide some nice conveniences:
- Add ls & grep coloring.
- conditional $PATH generation
- color variables
- git
- update check `dotfiles_check_updates`.
- as well as come conveniences such as `l`, `ll`, `la`, `ls`, `root`, `serve`.

# Configuration variables
in `~/.bash_config`
- `GIT_BRANCH_CHAR` - the character in the git branch. use this to change it if you've got a powerline font.
- `DOTFILES_DIR` - directory the git repo is in (for update checking)
- `TMUX_AUTO_OPEN` - auto open tmux.
- `COLORS_ENABLED` - enable/disable most colors.

# Custom Paths
in `~/.bash_path`
- This file is sourced and can contain system-specific executable search paths
- Follows the format `export_path <path_name>`, but you can do pretty much anything.


# Apply Dotfiles
**This overwrites whatever's there.**
- `./apply.sh` - save in $HOME.

# Scripts 
- `color_test.sh` - test color pallete
- `./update.sh` - pull local changes from $HOME into this repo.
