# Ubuntu 16.04
# Oracle Java 1.8.0_162 64 bit
# Maven 3.3.9

FROM ubuntu:16.04

# install wget
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y wget

# get maven 3.3.9
RUN wget --no-verbose -O /tmp/apache-maven-3.3.9.tar.gz http://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

# verify checksum
RUN echo "516923b3955b6035ba6b0a5b031fbd8b /tmp/apache-maven-3.3.9.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.3.9.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.3.9 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.3.9.tar.gz
ENV MAVEN_HOME /opt/maven

# set shell variables for java installation
ENV java_version 1.8.0_162
ENV filename jdk-8u162-linux-x64.tar.gz
ENV oraclehash 0da788060d494f5095bf8624735fa2f1
ENV downloadlink http://download.oracle.com/otn-pub/java/jdk/8u162-b12/$oraclehash/$filename


# download java, accepting the license agreement
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/$filename $downloadlink 

# unpack java
RUN mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk$java_version
ENV PATH $JAVA_HOME/bin:$PATH

# remove java download
RUN rm -f /tmp/$filename

# configure symbolic links for the java and javac executables
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

CMD [""]

# install libraries required for TestFX, and python 3.5
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    libxtst6 \
    libgtk2.0-0 \
    python3.5

