FROM rust:slim-buster

COPY . /spacemandmm

WORKDIR /spacemandmm

RUN cargo build -p cli --release
