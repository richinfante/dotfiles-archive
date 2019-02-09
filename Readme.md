# Dotfiles
These are the dotfiles I use installed on _most_ of my machines.
They provide some nice conveniences:
- Add ls & grep coloring.
- conditional $PATH generation
- color variables
- git branch in `$PS1`
- as well as come conveniences such as `l`, `ll`, `la`, `ls`, `root`, `serve`.

# Configuration variables
in `~/.bash_config`
- `GIT_BRANCH_CHAR` - the character in the git branch. use this to change it if you've got a powerline font.
- `PROMPT_DATE` - enable/disable `$PS1` date prefix
- `PROMPT_GIT` - enable/disable `$PS1` git branch prefix
- `COLORS_ENABLED` - enable/disable most colors.

# Apply Dotfiles
**This overwrites whatever's there.**
- `./dotfiles/apply.sh` - save in $HOME.

# Scripts 
- `color_test.sh` - test color pallete


# Custom Paths
in `~/.bash_path`
- This file is sourced and can contain system-specific executable search paths
- Follows the format `export_path <path_name>`, but you can do pretty much anything.
