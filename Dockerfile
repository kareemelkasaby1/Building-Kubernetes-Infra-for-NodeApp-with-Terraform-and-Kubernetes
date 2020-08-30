FROM jenkins/jenkins:lts
WORKDIR /mnt/certs
#cp /home/elkasaby/.minikube/certs /var/jenkins_home
COPY  . . 