# docker-mininet

The Docker image for [Mini-NDN](http://minindn.memphis.edu/index.html) on Ubuntu 20.04.

* Notes:
  * [Mininet](http://mininet.org/) built from source for Ubuntu 20.04.
  * Excludes explicit install of openvswitch* as Mininet install takes care of it.

## Docker Pull Command

Download from [Docker Hub](https://hub.docker.com/)

```bash
docker pull marahman/minindn
```

## Docker `run` command directed to `terminal`

```bash
docker run -m 4g --cpus=4 -it --rm --privileged -e DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v /lib/modules:/lib/modules \
           marahman/minindn:v0.1 bin/bash
```

* Notes:
  * Memory (-m), CPU (--cpus) are recommended by Mini-NDN.
  * `--privileged` is mandatory for underlying [Mininet](http://mininet.org/) to utilize virtual switch
  * Root directory on `run` is `/mini-ndn` containing the installation and examples.
    * [WIP] There might be error showing up regarding `infoedit` which can be resolved by running `./install -a` (once or twice). We're working on a fix.

## Docker Compose

If you have installed [Docker Compose](https://docs.docker.com/compose/),
you can run container with:

```bash
wget https://github.com/marahman/docker-minindn/raw/master/docker-compose.yml
docker-compose run --rm minindn
```

## TIPS

### Open X Window applications in containers

If you could not open `xterm` or other X Window applications, or faced to the
following error message;

```bash
root@acbb740afaae:~# xterm
No protocol specified
Warning: This program is an suid-root program or is being run by the root user.
The full text of the error or warning message cannot be safely formatted
in this environment. You may get a more descriptive message by running the
program as a non-root user or by removing the suid bit on the executable.
xterm: Xt error: Can't open display: %s
```

Please add `root` user to the local access control list of xhost on your
"Docker host" (not on your containers).

```bash
$ xhost +si:localuser:root
localuser:root being added to access control list
```
