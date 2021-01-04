#!/bin/bash

# Install Kramdown gem (including binary).
hash kramdown 2>/dev/null || gem install kramdown

# Install wkhtmltopdf.
hash wkhtmltopdf 2>/dev/null || brew install wkhtmltopdf

# Install HTML5 version of Tidy.
[[ $(type tidy) == 'tidy is /usr/local/bin/tidy' ]] || echo brew install tidy-html5

# UNIX convention is to succeed silently, but that seems a little too surprising for a setup script.
echo "All prerequisites installed."
