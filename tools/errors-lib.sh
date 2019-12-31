# Library of some common Shell commands:

# Write log messages to STDERR, prefixing each item after $1 (i.e. $2...)
# with the contents of $1:
log() {
  logLevel="$1"; shift
  for message in "$@"; do
    echo "${logLevel}: ${message}" >&2
  done
}

# Exit if $1 != "" or "continue":
exitp() {
  [ "$1" == "exit" ] && exit 1
  [ "$1" == "" ] || [ "$1" == "continue" ] || exit
}

# Run the given command (in $2...) and then exit with $1 as the status code:
eval_exit_code() {
  statusCode="$1"; shift

  "$@"
  [ "${statusCode}" == "" ] && exit
  exit "${statusCode}"
}

# "Run" the given args as a command, then exit with status code 1:
eval_exit() {
  eval_exit_code 1 "$@"
}

# Log the given args as an Error;  i.e. log each arg, prefixing with "ERR":
error() {
  log ERR "$@"
}

# Log the given args as an Error;  i.e. log each arg, prefixing with "WARN":
warn() {
  log WARN "$@"
}
