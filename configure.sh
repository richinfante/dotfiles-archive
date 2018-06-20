# System-independent configuration

export RED="\033[31m"
export LIGHT_GREEN="\033[92m"
export LIGHT_BLUE="\033[94m"
export RESET="\033[0m"

function run_cmd () {
  printf "${LIGHT_GREEN}RUN${RESET} $1 \n"
  eval "$1" | while read LINE ; do
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
  printf "${LIGHT_BLUE}INFO${RESET} $OPTIONS\n"
}

info "Infante System Config"
info "Version: $(git rev-parse HEAD)"

export -f run_cmd

# Perform OS-Specific configuration
if [[ $OSTYPE == darwin* ]]; then
  info "detected macOS"

  # Run macOS-Specific Configuration
  ./configurations/darwin.sh

elif [[ $OSTYPE == linux* ]]; then
  info "detected linux"
fi

# Apply dotfiles
run_cmd "bash ./dotfiles/apply.sh"
run_cmd "bash ~/.bash_profile"