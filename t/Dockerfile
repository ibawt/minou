FROM debian:buster-slim

RUN apt-get update -y
RUN apt-get install libreadline-dev build-essential cmake git -y

COPY . /minou

RUN mkdir -p /minou/build
WORKDIR /minou/build

RUN cmake ../

ENTRYPOINT ["bash", "-c", "make && ./minou-tests"]

