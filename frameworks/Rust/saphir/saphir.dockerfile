FROM rust:latest

WORKDIR /saphir

ADD . .

RUN cargo clean
RUN RUSTFLAGS="-C target-cpu=native" cargo build --release

EXPOSE 8080

CMD ./target/release/saphir-khulnasoft
