ARG OPENHANDS_VERSION
FROM docker.all-hands.dev/all-hands-ai/openhands:${OPENHANDS_VERSION}

RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
