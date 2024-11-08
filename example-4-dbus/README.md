# example-5-dbus
This is a brief example to show how to access the host dbus subsystem from a container.
Obviously, it reduces the isolation between both contexts, but this allows a deeper integration.

Note: before using 'build.sh' please set HTTP_PROXY to your APT cache, if any, to allow Docker engine to use it - enabling much faster builds.
      export HTTP_PROXY='http://localhost:3142'
      ./build.sh
