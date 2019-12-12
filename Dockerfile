FROM ubuntu
RUN apt-get -y update \
  && apt-get -y install build-essential libssl1.0 openssl zlib1g-dev libreadline6-dev libyaml-dev curl \
  && curl -sSL https://github.com/rvm/rvm/tarball/stable -o rvm-stable.tar.gz \
  && echo 'export rvm_prefix="$HOME"' > /root/.rvmrc \
  && echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmrc \
  && mkdir rvm && cd rvm \
  && tar --strip-components=1 -xzf ../rvm-stable.tar.gz \
  && ./install --auto-dotfiles --autolibs=0 \
  && cd ../ && rm -rf rvm-stable stable.tar.gz rvm \
  && /bin/bash -l -c "rvm install 2.1.7" \
