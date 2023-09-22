FROM ubuntu:latest
RUN apt-get update && apt-get install -y wget
RUN wget https://flatassembler.net/fasm-1.73.27.tgz
RUN tar xvf fasm-1.73.27.tgz
ENV PATH="/fasm:${PATH}"