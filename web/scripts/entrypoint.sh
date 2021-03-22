#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails
if [ -f /web/tmp/pids/server.pid ]; then
  rm /web/tmp/pids/server.pid
fi

# Creates the database and/or run migrations
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

# Exec the container's main process (what's set as CMD in the Dockerfile)
exec bundle exec "$@"
