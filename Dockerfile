FROM python:3.14.3-alpine3.23

LABEL org.opencontainers.image.source=https://github.com/mkody/twitch-stream-recorder
LABEL org.opencontainers.image.authors="Kody <gh@kdy.ch>"
LABEL org.opencontainers.image.description="twitch-stream-recorder - A Docker container to automatically record Twitch streams."
LABEL org.opencontainers.image.licenses=MIT

ARG UNAME=user
ARG UID=1000
ARG GID=1000

RUN apk add --no-cache ffmpeg~=8.0.1 tini~=0.19.0 && \
    python -m pip install --no-cache-dir --upgrade streamlink==8.1.0 && \
    addgroup -g "$GID" "$UNAME" && \
    adduser -D -u "$UID" -G "$UNAME" -s /bin/bash "$UNAME"

COPY --chown="$UID:$GID" entrypoint.sh twitch-recorder.py /opt/
RUN chmod 755 /opt/entrypoint.sh && \
    chown "$UID:$GID" /opt

USER $UNAME
ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
