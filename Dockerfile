FROM python:3-alpine

RUN apk update && apk upgrade

RUN apk add --no-cache tini

RUN apk add --no-cache ffmpeg

RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir --upgrade streamlink requests

COPY twitch-recorder.py /opt

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ARG UNAME=user
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID $UNAME
RUN adduser -D -u $UID -G $UNAME -s /bin/bash $UNAME
RUN chown -R $UID:$GID /opt
USER $UNAME

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
