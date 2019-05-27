from ubuntu:xenial

ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.2"
ARG ANDROID_SDK_TOOLS="4333796"

# Add extra architectures
RUN dpkg --add-architecture i386 ; dpkg --add-architecture armhf ; dpkg --add-architecture arm64
RUN sed -i 's/deb http/deb [arch=amd64,i386] http/' /etc/apt/sources.list
RUN grep "ubuntu.com/ubuntu" /etc/apt/sources.list | tee /etc/apt/sources.list.d/ports.list
RUN sed -i 's/amd64,i386/armhf,arm64/' /etc/apt/sources.list.d/ports.list
RUN sed -i 's#http://.*/ubuntu#http://ports.ubuntu.com/ubuntu-ports#' /etc/apt/sources.list.d/ports.list
RUN apt -qq update

# Install java and basic tools
RUN apt-get update && apt-get install -y \
    git \
	curl \
	ca-certificates \
	wget \
	bzip2 \
	zip \
	unzip \
	xz-utils \
	openjdk-8-jre-headless \
	openjdk-8-jdk-headless \
	maven \
	ant \
	gradle

# Install Native toolchain
RUN apt-get install -y make gcc g++ gcc-multilib g++-multilib g++-mingw-w64-i686 g++-mingw-w64-x86-64 ccache lib32stdc++6 lib32z1

# Install arm toolchains
RUN apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Install misc i386 deps (libstdc++-6-dev:i386 on Stretch/Bionic)
RUN apt-get install -y libstdc++-5-dev:i386

# Install x11 deps for gdx-controllers
RUN apt-get install -y libx11-dev libx11-dev:i386 libx11-dev:armhf libx11-dev:arm64

# Enable ccache
ENV PATH="/usr/lib/ccache:${PATH}"

RUN mkdir -p /opt/android-sdk-linux
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip -O android-sdk.zip
RUN unzip -q -d /opt/android-sdk-linux android-sdk.zip
RUN rm android-sdk.zip
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH="/opt/android-sdk-linux/platform-tools/:${PATH}"

RUN echo y | /opt/android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | /opt/android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | /opt/android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN yes | /opt/android-sdk-linux/tools/bin/sdkmanager --licenses

# Install NDK
RUN mkdir -p /opt/android-sdk-linux/ndk
RUN wget -q https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip -O ndk.zip
RUN unzip -q -d /opt/android-sdk-linux/ndk ndk.zip
RUN rm ndk.zip
ENV NDK_HOME=/opt/android-sdk-linux/ndk/android-ndk-r16b
ENV PATH="/opt/android-sdk-linux/ndk/android-ndk-r16b:${PATH}"

# Enable ccache for ndk
ENV NDK_CCACHE=/usr/bin/ccache

# Boot in /work directory
VOLUME /work
WORKDIR /work

