FROM buildpack-deps:bullseye

ENV DEBIAN_FRONTEND="noninteractive" TZ="America/New_York"
ENV PATH=/root/python3.6.9/bin:$PATH

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        build-essential libopenmpi-dev \
        libgdm-dev libz-dev \
        tk-dev libbluetooth-dev \
	tk-dev uuid-dev \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
RUN tar -xzf Python-3.6.9.tgz

WORKDIR Python-3.6.9
RUN ./configure --enable-optimizations --prefix=$HOME/python3.6.9
RUN make
RUN make install

RUN rm /Python-3.6.9.tgz \
  && rm -rf /Python-3.6.9
RUN ln -s /root/python3.6.9/bin/python3 /root/python3.6.9/bin/python \
  && ln -s /root/python3.6.9/bin/pip3 /root/python3.6.9/bin/pip

WORKDIR /
CMD ["python3"]
