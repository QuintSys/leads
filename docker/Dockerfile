FROM ruby:3.0.0-alpine3.13

ARG BUILD_PACKAGES="build-base linux-headers"
ARG DEV_PACKAGES="yarn=1.22.10-r0 postgresql-dev tzdata git"

ARG APP_USER=web_user
ARG APP_GROUP=web_group
ARG APP_USER_UID=1000
ARG APP_GROUP_GID=1000

ARG RAILS_ENV=production
ARG PORT=3000

ENV APP_PATH=/web \
    RAILS_ENV=$RAILS_ENV

# Add required packages and create non-privileged user
RUN apk update && \
    apk add --no-cache --virtual build_dependencies $BUILD_PACKAGES && \
    apk add --no-cache $DEV_PACKAGES && \
    mkdir $APP_PATH && \
    addgroup -g $APP_GROUP_GID -S $APP_GROUP && \
    adduser -S -s /sbin/nologin -u $APP_USER_UID -G $APP_GROUP $APP_USER && \
    chown $APP_USER:$APP_GROUP $APP_PATH

WORKDIR $APP_PATH
USER $APP_USER

# Install required ruby gems and npm packages
COPY --chown=$APP_USER:$APP_GROUP Gemfile* \
                                  package.json \
                                  yarn.lock \
                                  $APP_PATH/
COPY --chown=$APP_USER:$APP_GROUP scripts/install.sh /usr/bin/
RUN chmod u+x /usr/bin/install.sh && /usr/bin/install.sh

# Copy the whole application folder into the image
COPY --chown=$APP_USER:$APP_GROUP . ./

# Copy entrypoint into the image and make it executable
COPY --chown=$APP_USER:$APP_GROUP scripts/entrypoint.sh /usr/bin/
RUN chmod u+x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE $PORT
CMD ["rails", "server", "-b", "0.0.0.0"]
