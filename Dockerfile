FROM embida/quartus-eds-lite:latest
MAINTAINER Erik Liland <erik.liland@embida.no>
LABEL Description="This is a Quartus Jenkins Slave image, which allows connecting Jenkins agents via JNLP protocols" 

CMD docker cp jenkins/slave:latest:jenkins-slave/usr/local/bin/jenkins-slave

ENTRYPOINT ["jenkins-slave"]
