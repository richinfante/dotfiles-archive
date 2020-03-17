#!/bin/bash

# Debian CHROOT Support
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Bash Prompt String
export PS1="\[$RESET\]\$(\
  $(
    # DATE SECTION
    # This is run on every newline
  )\
  if [[ \"\$PROMPT_DATE\" == \"true\" ]]; then\
   echo \"\[$DATE_COLOR\]\D{%Y-%m-%d %H:%M:%S} \";\
  else\
    echo \"\";
  fi\
)\
$(
  # HOST SECTION
  # (hidden if not using ssh or remote)
)\
\[$RESET\]\[$HOST_COLOR\]\
${debian_chroot:+($debian_chroot) }\u\$(\
 if [ ! -z \"$SSH_CLIENT\" ] || \
    [ ! -z \"$SSH_TTY\" ] || \
    [ -f /.dockerenv ]; then \
  echo "@\\h";\
 fi
): \
$(
  # USER NAME
)\
\[\]\w \
$(
  # GIT COMPONENT
  # Attempt to get git branch
  # Errors piped to stdout so if no branch, no display.
)\
\[$GIT_COLOR\]\$(\
  if [[ \"\$PROMPT_GIT\" == "true" ]]; then\
    if git diff-index --quiet HEAD -- 2> /dev/null; then\
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1) /';\
    else \
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1 \*) /';\
    fi\
  fi\
)\
$(
  # SHELL TYPE INDICATOR
  # "$" or "#" depending on user/superuser
)\
\[$SHELL_TYPE_COLOR\]\$(\
  if [[ `whoami` == "root" ]]; then \
    echo '#'; \
    else echo '$';\
  fi\
)\[$RESET\] "

export PS2="\[$DIM$GRAY\]> \[$RESET\]"
export PS4="\[$DIM$GRAY\]+ \[$RESET\]"
