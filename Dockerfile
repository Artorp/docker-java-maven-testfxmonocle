FROM kaiwinter/docker-java8-maven

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    libxtst6 \
    libgtk2.0-0 \
    python3.5
