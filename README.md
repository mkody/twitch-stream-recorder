# twitch-stream-recorder
A Docker container to automatically record Twitch streams.

## Description
This repository hosts the source code for a Docker container that can automatically record livestreams from Twitch as they go live.
The main component is from [Ancalentari Twitch Stream Recorder](https://github.com/ancalentari/twitch-stream-recorder).

## Requirements
To run this container and record streams from Twitch, you need to register a dummy app and get a client_id and client_secret. Both is explained in the setup section.

## Setup
The container needs a few configuration parameters. These are:

`USERNAME`      - name of the streamer you want to record (Change this accordingly!)  
`QUALITY`       - this uses the streamlink [STREAM](https://streamlink.github.io/cli.html#cmdoption-arg-STREAM) setting to choose the quality to record.  
`CLIENT_ID`     - you can grab this from [here](https://dev.twitch.tv/console/apps) once you register your application (Replace with your own!)  
`CLIENT_SECRET` - you generate this [here](https://dev.twitch.tv/console/apps) as well, for your registered application (Replace with your own!)  
`AUTH_TOKEN`    - optionally your [OAuth Token](https://streamlink.github.io/cli/plugins/twitch.html#authentication) to prevent ad breaks if you're subscribed to the streamer.  
                  only add the string consisting of 30 alphanumerical characters without any quotations

Additionally, there are more advanced settings to set:

`DISABLE_FFMPEG`   - disables ffmpeg processing (fixing errors in recorded file) (Optional, defaults to True, Use "True" or "False")  
`REFRESH`          - the interval to check user availability (Optional, can't be set below 15, defaults to 15)  

## Usage
Start the container with the following `docker run` command:  
```bash
docker run -d \
   -e USERNAME=your_favourite_streamer \
   -e QUALITY=best \
   -e CLIENT_ID=your_client_id \
   -e CLIENT_SECRET=your_client_secret \
   -e AUTH_TOKEN=your_oauth_token_cookie \
   -v /path/to/recordings:/opt/recordings \
   ghcr.io/mkody/twitch-stream-recorder:master
```
The options in this command:  
`-v /path/to/recordings:/opt/recordings` Map a folder of your choice (left of ":") to a defined location in the container (right of ":"). This is the place where all recordings will be saved to.  
`ghcr.io/mkody/twitch-stream-recorder:master` Use the "master" tag for the latest version, that's the GitHub branch from which the Docker images will be built.

You can also run it as a Docker Compose setup, see [docker-compose.example.yml](docker-compose.example.yml).  
If you want to build the image while using Compose (ie. you changed the UID/GID) run `docker-compose up -d --build`.
