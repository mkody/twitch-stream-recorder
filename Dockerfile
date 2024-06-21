FROM python:3.12.2-alpine3.19

RUN apk add --no-cache tini=0.19.0-r3

RUN apk add --no-cache ffmpeg=6.1.1-r7

RUN python -m pip install --no-cache-dir --upgrade streamlink==6.8.1

COPY twitch-recorder.py /opt/

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
