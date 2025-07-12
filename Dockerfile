FROM python:3.13.5-alpine3.22

ARG UNAME=user
ARG UID=1000
ARG GID=1000

COPY entrypoint.sh /
COPY twitch-recorder.py /opt/

RUN apk add --no-cache ffmpeg~=6.1 tini~=0.19.0 && \
    python -m pip install --no-cache-dir --upgrade streamlink==7.5.0 && \
    chmod 755 /entrypoint.sh && \
    addgroup -g "$GID" "$UNAME" && \
    adduser -D -u "$UID" -G "$UNAME" -s /bin/bash "$UNAME" && \
    chown -R "$UID:$GID" /opt

USER $UNAME
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
