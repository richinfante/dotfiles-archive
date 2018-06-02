# System-independent configuration
PACKAGE_MANAGER=""

export RED="\033[31m"
export LIGHT_GREEN="\033[92m"
export LIGHT_BLUE="\033[94m"
export RESET="\033[0m"

printf "$LIGHT_GREEN"
cat banner.txt
printf "Version: $(git rev-parse HEAD)\n"
printf "$RESET"
printf "\n"

function run_cmd () {
  printf "${LIGHT_GREEN}RUN${RESET} $1 \n"
  $1 | while read LINE ; do
	  echo " ---> $LINE"
  done

  EXIT_CODE=$?
  if [[ "$EXIT_CODE" -ne "0" ]]; then
    printf " ---> ${RED}FAIL ($EXIT_CODE)${RESET}\n"
  else
    printf " ---> ${LIGHT_GREEN}OK${RESET}\n"
  fi
}


function info () {
  OPTIONS="$@"
  printf "${LIGHT_BLUE}INFO${RESET} $OPTIONS \n"
}

export -f run_cmd

# Perform OS-Specific configuration
if [[ $OSTYPE == darwin* ]]; then
  info "${LIGHT_BLUE}INFO${RESET} detected macOS"

  PACKAGE_MANAGER="brew"

  # Run macOS-Specific Configuration
  ./configurations/darwin.sh

elif [[ $OSTYPE == linux* ]]; then
  PACKAGE_MANAGER="sudo apt-get"
fi

# Install Programs
run_cmd "$PACKAGE_MANAGER update"
run_cmd "$PACKAGE_MANAGER upgrade"
run_cmd "$PACKAGE_MANAGER install vim git tmux curl wget gcc"

if [[ "$PACKAGE_MANAGER" == "brew" ]]; then
  run_cmd "$PACKAGE_MANAGER install tldr"
fi

# Apply dotfiles
./dotfiles/apply.sh