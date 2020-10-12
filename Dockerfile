FROM rust:slim-buster

COPY . .

WORKDIR /usr/src/myapp

RUN cargo build -p cli --release
