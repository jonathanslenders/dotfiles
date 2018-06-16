#!/bin/bash

# If pypager has been installed, use that.
if [ $(which  pypager) ]; then
    pypager "$@"

# If 'most' is installed, use this as pager.
elif [ -e /usr/bin/most ]; then
    /usr/bin/most "$@"
fi
