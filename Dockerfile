FROM alpine:latest

ARG DOCTL_VERSION
ENV DOCTL_VERSION=1.23.1
ENV KUBE_LATEST_VERSION="v1.15.9"

WORKDIR /app

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
 && curl -L https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz | tar xz \
 && mv /app/doctl /usr/local/bin/doctl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

CMD ["help"]
