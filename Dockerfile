FROM embida/quartus-eds-lite:latest
MAINTAINER Erik Liland <erik.liland@embida.no>
LABEL Description="This is a Quartus Jenkins Slave image, which allows connecting Jenkins agents via JNLP protocols" 

CMD docker cp jenkins/slave:latest:jenkins-slave/usr/local/bin/jenkins-slave
CMD apt -qq update \
    && apt install -y repo build-essential default-jdk python-dev python-pip python3-dev python3-pip libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi gcc-arm-linux-gnueabihf libncurses5-dev flex bison curl  apt-transport-https  ca-certificates  software-properties-common icedtea-netx icedtea-plugin slick-greeter debconf debconf-utils debootstrap  qemu-user-static htop 

ENTRYPOINT ["jenkins-slave"]
