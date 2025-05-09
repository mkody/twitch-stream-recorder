# twitch-stream-recorder
A Docker container to automatically record Twitch streams.

## Description
This repository hosts the source code for a Docker container that can automatically record livestreams from Twitch as they go live. The main component is from [Ancalentari Twitch Stream Recorder](https://github.com/ancalentari/twitch-stream-recorder).

## Requirements
To run this container and record streams from Twitch, you need to register a dummy app and get a `client_id` and `client_secret`. Both are explained in the setup section.

## Setup
The container needs a few configuration parameters. These are:

- `USERNAME`        - Name of the streamer you want to record.
- `QUALITY`         - This uses the streamlink [STREAM](https://streamlink.github.io/cli.html#cmdoption-arg-STREAM) setting to choose the quality to record.
- `CLIENT_ID`       - You can grab this from [here](https://dev.twitch.tv/console/apps) once you register your application.
- `CLIENT_SECRET`   - You generate this [here](https://dev.twitch.tv/console/apps) as well, for your registered application.

Additionally, there are more advanced settings to set:

- `AUTH_TOKEN`      - Your [OAuth Token](https://streamlink.github.io/cli/plugins/twitch.html#authentication) to prevent ad breaks if you're subscribed to the streamer.  
                      (Optional, only add the string consisting of 30 alphanumerical characters without any quotations.)
- `DISABLE_FFMPEG`  - Disables ffmpeg processing (fixing errors in recorded file).  
                      (Optional, defaults to `False`. Use `True` or `False`.)
- `REFRESH`         - The interval to check user availability.  
                      (Optional, defaults to `15`. Can't be set below `15`.)

## Usage
Start the container with the following `docker run` command:

```bash
docker run -d \
    -e USERNAME=your_favourite_streamer \
    -e QUALITY=best \
    -e CLIENT_ID=your_client_id \
    -e CLIENT_SECRET=your_client_secret \
    -v /path/to/recordings:/opt/recordings \
    ghcr.io/mkody/twitch-stream-recorder:master
```

The options in this command:  
- `-d` - Run this in the background.
- `-e [...]` - They set the environment variables, please refer to the [Setup](#setup) section.
- `-v /path/to/recordings:/opt/recordings` - Map a folder of your choice (left of ":") to a defined location in the container (right of ":"). This is the place where all recordings will be saved to.  
- `ghcr.io/mkody/twitch-stream-recorder:master` - The image to use, here with the "master" tag for the latest version, that's the GitHub branch from which the Docker images will be built.

You can also run it as a Docker Compose setup, see [compose.example.yaml](compose.example.yaml).  
To build an image while using Compose (i.e. you changed the UID/GID) run `docker compose up -d --build`.
