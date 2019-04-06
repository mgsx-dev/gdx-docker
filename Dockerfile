from debian:stretch

# Add extra architectures
RUN dpkg --add-architecture i386 ; dpkg --add-architecture armhf ; dpkg --add-architecture arm64

# Install basic tools
RUN apt-get update -y && apt-get install -y wget git zip unzip

# Install Native toolchain
RUN apt-get install -y make gcc g++ gcc-multilib g++-multilib g++-mingw-w64-i686 g++-mingw-w64-x86-64 ccache lib32z1

# Install arm toolchains
RUN apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Install misc i386 deps
RUN apt-get install -y libstdc++-6-dev:i386

# Install x11 deps for gdx-controllers
RUN apt-get install -y libx11-dev libx11-dev:i386 libx11-dev:armhf libx11-dev:arm64

# Install NDK
RUN mkdir /ndk && cd /ndk && wget https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip -O ndk.zip && unzip ndk.zip && rm ndk.zip
ENV NDK_HOME /ndk/android-ndk-r13b

# Install Java
RUN apt-get install -y default-jdk-headless ant maven
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64


# Install LibGDX tools
RUN mkdir /libgdx
WORKDIR /libgdx

# Download packr openjdk images
RUN wget https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/openjdk-1.7.0-u80-unofficial-macosx-x86_64-image.zip
RUN wget https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/openjdk-1.7.0-u80-unofficial-windows-amd64-image.zip
RUN wget https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/openjdk-1.7.0-u80-unofficial-linux-amd64-image.zip

# Download packr.jar
RUN wget http://libgdx.badlogicgames.com/packr/packr.jar


# Install scripts
COPY ./scripts/ /usr/bin/

# Boot in /work directory
VOLUME /work
WORKDIR /work
