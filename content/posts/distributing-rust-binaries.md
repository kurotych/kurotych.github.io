---
title: "Building and Deploying Rust Binaries Across Linux Distributions."
date: 2024-02-11T13:09:33+02:00
---

The Rust ecosystem has numerous platforms and extensive documentation to support cross-compilation features.

But does it work as expected?

Well, if your binary has few shared library dependencies,
then it likely will. Compiling for `x86_64-unknown-linux-musl` significantly increases the likelihood that your binary will operate across different 
Linux distributions.

**However**, the reality in production can be quite different.
We still encounter dependency hell, and many Rust crates rely on shared libraries that may have varying names and paths.

One of my projects has about 120 dependencies on shared library and codebase of this project is not big (It has around 10k lines with tests).
(Despite my effors to minimize the amount of dependencies.)

To verify dependencies, I use the ldd Linux utility:
```
ldd <path_to_binary>
	libssl.so.3 => /lib/x86_64-linux-gnu/libssl.so.3 (0x00007f912c971000)
	libcrypto.so.3 => /lib/x86_64-linux-gnu/libcrypto.so.3 (0x00007f9129800000)
    ...
	libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007f9124096000)
	libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f91239f9000)
	libquadmath.so.0 => /lib/x86_64-linux-gnu/libquadmath.so.0 (0x00007f9121bb9000)
```

So, what are the chances that this binary, built on Debian 12, will work with Ubuntu 22.04, for example? (This question is rhetorical.)

### Problem
The challenge is to build a binary, deliver it, and run it on an Ubuntu 22.04 VPS (or any other Linux distro you prefer) with only runtime dependencies.

### Solution
[Build binary in docker and export it](https://docs.docker.com/build/guide/export/) to VPS.  

The docker file that builds **hello_world** binary could looks something like:
```Dockerfile
FROM ubuntu:22.04 AS build-stage

ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    <package_name>... # A list of deps used to build binary
    && rm -rf /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# Set the working directory inside the container
WORKDIR /usr/src/app/

COPY . .

RUN SQLX_OFFLINE=true ~/.cargo/bin/cargo build --release

FROM scratch AS export-stage
COPY --from=build-stage /usr/src/app/target/release/hello_world

CMD ["/bin/bash"]
```

The build command `docker build -f <your_docker_file_name> --output=bin  .` will deliver the built binary to `bin` directory.

Then, you can use the `scp` utility to transfer this binary to your VPS.

If the binary requires certain shared libraries, you will need to install them with your package manager (in case of ubuntu `apt` or `apt-get`)
