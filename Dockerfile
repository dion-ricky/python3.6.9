FROM ubuntu:bionic
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
	wget
RUN wget --no-check-certificate https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
RUN tar -xzf Python-3.6.9.tgz
ENV DEBIAN_FRONTEND="noninteractive" TZ="America/New_York"
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
	build-essential libopenmpi-dev \
	libncurses-dev libgdm-dev libz-dev \
	tk-dev libsqlite3-dev libreadline-dev \
	liblzma-dev libffi-dev libssl-dev \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
WORKDIR Python-3.6.9
RUN ./configure --enable-optimizations --prefix=$HOME/python3.6.9
RUN make
RUN make install
ENV PATH=/root/python3.6.9/bin:$PATH
RUN rm /Python-3.6.9.tgz \
  && rm -rf /Python-3.6.9
RUN ln -s /root/python3.6.9/bin/python3 /root/python3.6.9/bin/python \
  && ln -s /root/python3.6.9/bin/pip3 /root/python3.6.9/bin/pip
WORKDIR /root
ENTRYPOINT python3
