#!/bin/sh
set -e

echo "env: $RAILS_ENV"
if [ "$RAILS_ENV" == "production"  ]; then 
  yarn install --check-files --frozen-lockfile
  bundle config set frozen 'true'
  bundle config set without 'development test'
else
  yarn install --check-files --audit
fi

cores=`cat /proc/cpuinfo | grep -c "cpu cores"`
bundle install --retry 3 --jobs $(($cores-1))

if [ "$RAILS_ENV" == "production"  ]; then 
  rails assets:precompile 
fi
