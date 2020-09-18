FROM node:13-alpine

RUN apk add --no-cache \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  openssl \
  openssl-dev \
  openssh-client \
  less \
  groff \
  bash \
  curl \
  graphviz \ 
  git \
  gcc \
  jq \
  zip \
  libc-dev \
  gnupg \
  ttf-linux-libertine

RUN pip install --no-cache-dir --upgrade pip awscli boto3

RUN npm init -y && \
    npm install -g graphqlviz && \
    npm install -g xgql && \
    npm install -g graphql-schema-linter

RUN rm package*.json

# Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

RUN git clone https://github.com/hoop33/gumwood.git /opt/gumwood && \
      cd /opt/gumwood && \
      /root/.cargo/bin/cargo build --release && \
      ln -s /opt/gumwood/target/release /bin/gumwood

# Go
ENV GOLANG_VERSION 1.15.2
RUN goRelArch='linux-amd64'; \
    goRelSha256='b49fda1ca29a1946d6bb2a5a6982cf07ccd2aba849289508ee0f9918f6bb4552' && \
    wget --quiet -O go.tgz https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz && \
	echo "$goRelSha256 *go.tgz" | sha256sum -c - && \
	tar -C /usr/local -xzf go.tgz && \
	rm go.tgz && \
	mkdir /lib64 && \
	ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
	export PATH="/usr/local/go/bin:$PATH" && \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && \
    go get -u github.com/golang/dep/cmd/dep

ENV BOT graphql-bot

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]

