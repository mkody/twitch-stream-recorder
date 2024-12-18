FROM python:3.13.1-alpine3.20

RUN apk add --no-cache tini~=0.19.0

RUN apk add --no-cache ffmpeg~=6.1

RUN python -m pip install --no-cache-dir --upgrade streamlink==7.0.0

COPY twitch-recorder.py /opt/

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
