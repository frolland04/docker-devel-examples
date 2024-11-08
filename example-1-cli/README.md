# example-1-cli
This is a very bare CLI example, for using 'bash' in a containerized environment.

Note: before using 'build.sh' please set HTTP_PROXY to your APT cache, if any, to allow Docker engine to use it - enabling much faster builds.
      export HTTP_PROXY='http://localhost:3142'
      ./build.sh
