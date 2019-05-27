
# LibGDX image

Docker image to build LibGDX Games or Extensions : https://hub.docker.com/r/mgsx/gdx-docker/

This image provides all what you need in order to :
* Create distribution of your game for all LibGDX supported platforms.
* Build native code for some LibGDX supported platforms (all exept MacOSX and iOS).

This image contains :
* OpenJDK-8
* Maven
* Gradle
* Ant
* Android SDK
* Native toolchain (GCC, MinGW, NDK, Linux armhf/aarch64)
* ccache enabled for all native toolchains

# How to use this image

To run a docker container in your current directory (eg. your LibGDX project directory), type

`docker run --rm -v $(pwd) -it mgsx/gdx-docker bash`

This will run a new container binding current folder to container work folder.

Once in container, you can run for instance `./gradlew build`