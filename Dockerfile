FROM python:3.13.2-alpine3.21

RUN apk add --no-cache tini=0.19.0-r3

RUN apk add --no-cache ffmpeg=6.1.2-r1

RUN python -m pip install --no-cache-dir --upgrade streamlink==7.1.3

COPY twitch-recorder.py /opt/

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/tini", "--", "python", "/opt/twitch-recorder.py"]
