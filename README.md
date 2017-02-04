Docker image to use latex in Scientific Linux

Download from Dockerhub:

- https://hub.docker.com/r/manuelmarcano22/dockerlatex/

To use and be able to visualize the pdf with evince do:

`docker run -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --name latex manuelmarcano22/dockerlatex`

Might need to do 

`xhost local:root` 

and 

`root@container#dbus-uuidgen >/etc/machine-id`
