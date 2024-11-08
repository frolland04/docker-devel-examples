# example-5-ssh
This is a short example to show how to inject SSH credentials and/or configuration into the *container*, without requiring to store them in the Docker *image*.
Please have a look into 'example-5-ssh/.ssh' before *starting* the container and provide the needed things to successfully connect to a given URL.

Note: before using 'build.sh' please set HTTP_PROXY to your APT cache, if any, to allow Docker engine to use it - enabling much faster builds.
      export HTTP_PROXY='http://localhost:3142'
      ./build.sh
