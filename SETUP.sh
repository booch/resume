#!/bin/bash

# Install Kramdown gem (including binary).
if ! command -v kramdown &> /dev/null ; then
    gem install kramdown
fi

# Install weasyprint, if it's not already installed.
if ! command -v weasyprint &> /dev/null ; then
    brew install -q weasyprint
fi

# Install HTML5 version of Tidy.
if ! command -v tidy &> /dev/null ; then
    brew install tidy-html5
fi

# UNIX convention is to succeed silently, but that seems a little too surprising for a setup script.
echo "All prerequisites installed."
