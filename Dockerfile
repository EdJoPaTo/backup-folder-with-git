FROM docker.io/library/alpine:3.16
RUN apk upgrade --no-cache \
	&& apk add --no-cache bash git rsync openssh-client-default

WORKDIR /
VOLUME /data
VOLUME /backuprepo

COPY gitconfig /root/.gitconfig
COPY known_hosts /root/.ssh/known_hosts
COPY main.sh /usr/local/bin/backup-folder-with-git

CMD backup-folder-with-git
