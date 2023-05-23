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
`CLIENT_ID`     - you can grab this from [here](https://dev.twitch.tv/console/apps) once you register your application (Replace with your own!)  
`CLIENT_SECRET` - you generate this [here](https://dev.twitch.tv/console/apps) as well, for your registered application (Replace with your own!)  
`AUTH_TOKEN`    - optionally your [OAuth Token](https://streamlink.github.io/cli/plugins/twitch.html#authentication) to prevent ad breaks if you're subscribed to the streamer  
                  only add the string consisting of 30 alphanumerical characters without any quotations

## Usage
Start the container with the following `docker run` command:  
```bash
docker run -d \
   -e USERNAME=your_favourite_streamer \
   -e CLIENT_ID=your_client_id \
   -e CLIENT_SECRET=your_client_secret \
   -e AUTH_TOKEN=your_oauth_token_cookie \
   -v /path/to/recordings:/opt/recordings \
   ghcr.io/mkody/twitch-stream-recorder:master
```
The options in this command:  
`-v /path/to/recordings:/opt/recordings` Map a folder of your choice (left of ":") to a defined location in the container (right of ":"). This is the place where all recordings will be saved to.  
`ghcr.io/mkody/twitch-stream-recorder:master` Use the "master" tag for the latest version, that's the GitHub branch from which the Docker images will be built.

You can also run it as a Docker Compose setup, see [docker-compose.yml](docker-compose.yml).  
If you want to build the image while using Compose (ie. you changed the UID/GID) run `docker-compose up -d --build`.

## Notes
Open TODOs for future improvements:
- [x] Switch to alpine based images
- [x] Add "tini" init system
- [x] Allow configuration via env variables
- [x] Run process as non-root user
- [ ] Add "latest" tag
- [ ] Run GitHub Action on a regular base
- [ ] Separate container tags for the regular built images?
- [ ] How many versions of the image do i want to store on GitHub?
- [ ] Cross build image for ARM architecture
