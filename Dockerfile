FROM python:3.11.4-alpine3.18

RUN apk add --no-cache tini=0.19.0-r1

RUN apk add --no-cache ffmpeg=6.0-r14

RUN python -m pip install --no-cache-dir --upgrade streamlink==5.5.1

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
