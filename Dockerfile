FROM rust:slim-buster as base

#-------------------------------------------------------------------------------
# Build SpacemanDMM from the Rust code
#-------------------------------------------------------------------------------
FROM base as spacemandmm_build

#
# Install Debian packages
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    && rm -rf /var/lib/apt/lists/*

COPY . /spacemandmm

WORKDIR /spacemandmm

RUN cargo build --release

#-------------------------------------------------------------------------------
# Create the docker image for SpacemanDMM
#-------------------------------------------------------------------------------
FROM debian:buster-slim as spacemandmm_image

COPY --from=spacemandmm_build /spacemandmm/target/release/dmdoc /spacemandmm/target/release/dmdoc
COPY --from=spacemandmm_build /spacemandmm/target/release/dm-langserver /spacemandmm/target/release/dm-langserver
COPY --from=spacemandmm_build /spacemandmm/target/release/dmm-tools /spacemandmm/target/release/dmm-tools
COPY --from=spacemandmm_build /spacemandmm/target/release/dreamchecker /spacemandmm/target/release/dreamchecker
COPY --from=spacemandmm_build /spacemandmm/target/release/editor /spacemandmm/target/release/editor
