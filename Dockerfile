FROM jenkins/jenkins:lts
WORKDIR /mnt/certs
#cp /home/elkasaby/.minikube/certs /var/jenkins_home
COPY  . . 

USER root

################################
# Install ansible
################################

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt update -y
RUN apt install ansible -y
RUN ansible --version

RUN su jenkins