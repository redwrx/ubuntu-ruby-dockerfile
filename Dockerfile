FROM ubuntu
RUN mkdir /app
COPY . /app
RUN /bin/bash -l \
  && apt-get -y update \
  && apt-get -y install build-essential libssl1.0 openssl git libpq-dev\
  zlib1g-dev libreadline6-dev libyaml-dev libmysqlclient-dev curl \
  libmagickwand-dev imagemagick \
  && curl -sSL https://github.com/rvm/rvm/tarball/stable -o rvm-stable.tar.gz \
  && echo 'export rvm_prefix="$HOME"' > /root/.rvmrc \
  && echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmrc \
  && mkdir rvm && cd rvm \
  && tar --strip-components=1 -xzf ../rvm-stable.tar.gz \
  && ./install --auto-dotfiles --autolibs=0 \
  && cd ../ && rm -rf rvm-stable stable.tar.gz rvm \
  && . $HOME/.rvm/scripts/rvm \
  && /bin/bash -l -c "rvm install 2.1.7" \
  && export RUBYOPT="-KU -E utf-8:utf-8" \
  && cd /app \
  && /bin/bash -l -c "rvm use 2.1.7" \
  && /bin/bash -l -c "bundle install" \
  && rm -r /app
