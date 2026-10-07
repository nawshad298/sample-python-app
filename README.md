python-app-docker-demo

This demo shows two steps:
1. Install docker on ubuntu 22.04
2. Build and run a simple docker image with a python+flask+gunicorn web application.

Install docker on Ubuntu 22.04:
Refer to https://docs.docker.com/engine/install/ubuntu/ You can also find other OS installation docs from here.

Install using the apt repository:
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

$ sudo apt update

Install the Docker latest packages.
$ sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

After installation, verify that Docker is running:
$ sudo systemctl status docker.service

If Docker is not running, start it manually:
$ sudo systemctl start docker

Verify that the installation is successful by running the hello-world image:
$ sudo docker run hello-world


Build/Run a simple python+flask docker web app:
Create the Dockerfile:

Build your image:
Normally, image name convention is something like:  {company/application-name}:{version-number}. In the demo, I just use {application-name}:{version-number}

$ sudo docker build -t my-python-app:1.0.1 .

check all docker images:
$ sudo docker images
IMAGE                                     ID               DISK USAGE   CONTENT SIZE   EXTRA
sample-python-app:1.0       656d479cf26d        627MB                158MB 

Run your image:
$ sudo docker run -d --name sample-python-app  -p 8080:8080 sample-python-app:1.0

$ sudo docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                         NAMES
b7058ebeb418   sample-python-app:1.0   "gunicorn -b :8080 -…"   19 seconds ago   Up 19 seconds   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp   sample-python-app

login inside the container:
$ sudo docker exec -it 4de6041072b7 /bin/sh
# ls 
Dockerfile  README.md  gunicorn.conf.py  gunicorn_pid.txt  main.py  main.pyc  requirements.txt
# exit


Test your application
$ curl http://localhost:8080
Hello World



