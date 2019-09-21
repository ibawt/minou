FROM debian:bullseye-slim

RUN apt-get update -y
RUN apt-get install zlib1g-dev libreadline-dev build-essential cmake git llvm-8 -y

COPY . /minou

RUN mkdir -p /minou/build
WORKDIR /minou/build

RUN cmake ../

ENTRYPOINT ["bash", "-c", "make && ./minou-tests"]

