#!/bin/bash

CONFIG="~/.ssh/config"
CONFIGDIR="~/.ssh/config.d"

TOKEN="MANAGED BY SSH-CONFIGD"

function error_exit {
    echo "$@"
    exit 1
}

function generate_ssh_config {
    set -e
    cd ~/.ssh
    echo "# $TOKEN" > config.new
    echo "# Generated: $(date)" >> config.new
    echo "" >> config.new
    
    cat config.d/*conf >> config.new
    cp config config.last
    mv config.new config
    set +e
}

function setup_stuff {
    echo "Looks like you're not setup yet"
    echo "Want me to setup for you?"
    echo "Return to continue, control-c to cancel"
    echo "..."
    read response

    cd ~/.ssh || error_exit "No .ssh?"
    mkdir config.d
    cp config config.d/10original.conf
    generate_ssh_config    
}

function check_setup {
    cd ~/.ssh || error_exit "No .ssh?"

    grep -q "$TOKEN" config
    token_present=$?

    test -d config.d
    dir_exists=$?

    case $(($token_present + $dir_exists)) in
	0)
	# Setup correctly
	;;
	1)
	    # Partial setupWTF
	    error_exit "Partially Setup. WTF"
	    ;;
	2)
	    # Not setup yet
	    setup_stuff
	    ;;
	*)
	    # WTF
	    error_exit "How did you get here"
	    ;;
    esac
}

check_setup
generate_ssh_config
