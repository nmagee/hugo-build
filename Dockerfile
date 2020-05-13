FROM alpine:latest
MAINTAINER nmagee@virginia.edu

WORKDIR /root/
ENV AWS_DEFAULT_REGION us-east-1

# Update, install Git and things
RUN apk update && apk add git && apk add python2-dev && apk add py-yuicompressor && apk add coreutils && rm -rf /var/cache/apk/*

# Install Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.tar.gz hugo.tar.gz
RUN tar -xzf hugo.tar.gz
RUN mv hugo /usr/local/bin

# Intall future version of Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_0.69.0_Linux-64bit.tar.gz hugo-0.69.tar.gz
RUN tar -xzf hugo-0.69.tar.gz
RUN mv hugo /usr/local/bin/hugo-0.69

# Install AWSCLI
ADD https://s3.amazonaws.com/aws-cli/awscli-bundle.zip awscli-bundle.zip
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Copy in script
COPY build-site.sh /root/build-site.sh
RUN chmod +x /root/build-site.sh
