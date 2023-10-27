FROM python:3.12.0-alpine3.18

RUN apk add --no-cache tini=0.19.0-r1

RUN apk add --no-cache ffmpeg=6.0-r15

RUN python -m pip install --no-cache-dir --upgrade streamlink==6.3.1

COPY twitch-recorder.py /opt/

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
