# example-3-enhanced
This is a fully-fledged dev environment providing more tools, like Google Chrome or VScode.
It also shows how to make some important data persistent, letting them stored by the host in a bind-mounted folder into the container (could be interesting for settings, data or source code folders, home directories, etc.).

Note: before using 'build.sh' please set HTTP_PROXY to your APT cache, if any, to allow Docker engine to use it - enabling much faster builds.
      export HTTP_PROXY='http://localhost:3142'
      ./build.sh
