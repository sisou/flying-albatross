#!/bin/bash

set -e

# Create the config from the template
if [[ -e "/home/nimiq/.nimiq/client.tmpl.toml" ]]; then
    envsubst < /home/nimiq/.nimiq/client.tmpl.toml > /home/nimiq/.nimiq/client.toml
fi

# Start the node
/usr/local/bin/nimiq-client $@
