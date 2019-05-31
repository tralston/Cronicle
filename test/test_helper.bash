load 'lib/bats-support/load'                                                                                                                                     
load 'lib/bats-assert/load'
load 'lib/bats-file/load'

diag() {
    echo "$@" | sed -e 's/^/# /' >&3 ;
}

node="/usr/bin/env node"