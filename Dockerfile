FROM ghcr.io/nimiq/core-rs-albatross:latest

# Switch to root user for installing packages
USER root

# Install dependencies.
RUN apt-get update \
    && apt-get install --no-install-recommends -y gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Fix permissions on config file
RUN chown nimiq:nimiq /home/nimiq/.nimiq/client.toml

# Include config template
COPY --chown=nimiq:nimiq ./client.tmpl.toml /home/nimiq/.nimiq/

# Inlude entrypoint
COPY --chown=nimiq:nimiq ./fly_run.sh /home/nimiq/

# Switch to nimiq user
USER nimiq

# Run launch script
CMD [ "/usr/bin/tini", "--", "/home/nimiq/fly_run.sh" ]
