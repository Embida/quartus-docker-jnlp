FROM embida/quartus-eds-lite:latest
MAINTAINER Erik Liland <erik.liland@embida.no>
LABEL Description="This is a Quartus Jenkins Slave image, which allows connecting Jenkins agents via JNLP protocols" 

RUN apt update
RUN apt install -y repo docker build-essential default-jdk python-dev python-pip python3-dev python3-pip libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi gcc-arm-linux-gnueabihf libncurses5-dev flex bison curl  apt-transport-https  ca-certificates  software-properties-common icedtea-netx icedtea-plugin debconf debconf-utils debootstrap  qemu-user-static htop 

ARG VERSION=3.29
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV HOME /home/${user}
RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d $HOME -u ${uid} -g ${gid} -m ${user}

ARG AGENT_WORKDIR=/home/${user}/agent

RUN curl --create-dirs -fsSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 755 /usr/share/jenkins/slave.jar

USER ${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}

ENTRYPOINT ["/usr/share/jenkins/slave.jar"]
