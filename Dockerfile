FROM        hauptmedia/java:oracle-java7

ENV         DEBIAN_FRONTEND noninteractive

ENV     JMETER_VERSION  3.0
ENV     JMETER_HOME /opt/jmeter
ENV     JMETER_DOWNLOAD_URL  http://mirror.serversupportforum.de/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# install needed debian packages & clean up
RUN     apt-get update && \
        apt-get install -y --no-install-recommends curl tar ca-certificates unzip && \
        apt-get clean autoclean && \
            apt-get autoremove --yes && \
            rm -rf /var/lib/{apt,dpkg,cache,log}/

# download and extract jmeter 
RUN     mkdir -p ${JMETER_HOME} && \
        curl -L --silent ${JMETER_DOWNLOAD_URL} | tar -xz --strip=1 -C ${JMETER_HOME} && \
        curl -L --silent http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip -o /tmp/jmeter-plugins-standard.zip && \
        curl -L --silent http://central.maven.org/maven2/postgresql/postgresql/9.0-801.jdbc4/postgresql-9.0-801.jdbc4.jar -o /opt/jmeter/lib/postgresql-9.0-801.jdbc4.jar && \
        unzip -o -d /opt/jmeter/ /tmp/jmeter-plugins-standard.zip && \
        rm /tmp/jmeter-plugins-standard.zip

WORKDIR     ${JMETER_HOME}
