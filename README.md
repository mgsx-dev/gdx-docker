
# LibGDX image

Docker image to build LibGDX Games or Extensions. See https://libgdx.badlogicgames.com.

This image provides all what you need in order to :
* Create distribution of your game for all LibGDX supported platforms.
* Build native code for some LibGDX supported platforms (all exept MacOSX and iOS).

This image contains :
* Packr : LibGDX application packager tool.
* some java distributions from https://bitbucket.org/alexkasko
* Native toolchain (GCC, MinGW, NDK)

# How to use this image

To run a docker container in your current directory (eg. your LibGDX project directory), type

`docker run --rm -v $(pwd) -it mgsx/libgdx bash`

This will run a new container binding current folder to container work folder.

Once in container, you can run for instance `./gradlew build`

Some provided scripts are available in PATH :
* packr
