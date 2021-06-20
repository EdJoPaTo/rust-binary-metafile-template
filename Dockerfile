FROM docker.io/library/alpine:edge as builder
WORKDIR /build
RUN apk --no-cache upgrade \
    && apk --no-cache add cargo \
    && rustc --version && cargo --version

# cargo needs a dummy src/main.rs to detect bin mode
RUN mkdir -p src && echo "fn main() {}" > src/main.rs

COPY Cargo.toml Cargo.lock ./
RUN cargo build --release

# We need to touch our real main.rs file or the cached one will be used.
COPY . ./
RUN touch src/main.rs

RUN cargo build --release


FROM docker.io/ekidd/rust-musl-builder as builder
WORKDIR /home/rust

# cargo needs a dummy src/main.rs to detect bin mode
RUN mkdir -p src && echo "fn main() {}" > src/main.rs

COPY Cargo.toml Cargo.lock ./
RUN cargo build --release

# We need to touch our real main.rs file or the cached one will be used.
COPY . ./
RUN sudo touch src/main.rs

RUN cargo build --release

# Size optimization
RUN strip target/x86_64-unknown-linux-musl/release/rust-binary-metafile-template


# Start building the final image
FROM docker.io/library/alpine
WORKDIR /app

RUN apk --no-cache upgrade && apk --no-cache add libgcc

COPY --from=builder /build/target/release/rust-binary-metafile-template /usr/bin/
COPY --from=builder /home/rust/target/x86_64-unknown-linux-musl/release/rust-binary-metafile-template /usr/bin/

ENTRYPOINT ["rust-binary-metafile-template"]
