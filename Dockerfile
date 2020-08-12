FROM alpine:latest
MAINTAINER nmagee@virginia.edu

WORKDIR /root/
ENV AWS_DEFAULT_REGION us-east-1

# Update, install Git and things
RUN apk update && apk add py-pip git python2-dev py-yuicompressor coreutils && rm -rf /var/cache/apk/*

# Install
RUN pip install setuptools

# Install Hugo 0.59
ADD https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.tar.gz hugo.tar.gz
RUN tar -xzf hugo.tar.gz
RUN mv hugo /usr/local/bin

# Install Hugo 0.69
ADD https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_0.69.0_Linux-64bit.tar.gz hugo-0.69.0.tar.gz
RUN tar -xzf hugo-0.69.0.tar.gz
RUN mv hugo /usr/local/bin/hugo-0.69.0

# Install Hugo 0.71-extended
ADD https://github.com/gohugoio/hugo/releases/download/v0.71.0/hugo_extended_0.71.0_Linux-64bit.tar.gz hugo-ext-0.71.0.tar.gz
RUN tar -xzf hugo-ext-0.71.0.tar.gz
RUN mv hugo /usr/local/bin/hugo-0.71.0-ext

# Install AWSCLI
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Copy in script
COPY build-site.sh /root/build-site.sh
RUN chmod +x /root/build-site.sh
