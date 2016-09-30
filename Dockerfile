FROM ubuntu:latest
MAINTAINER Steven <steven.vandenberghe@sirris.be>

#install tini
ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

#install packages
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends openjdk-8-jdk-headless wget python3.4 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

#build spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0.tgz && tar xvzf spark-2.0.0.tgz
WORKDIR spark-2.0.0
COPY pom.xml .
RUN ./dev/make-distribution.sh --name spark-swift -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver
WORKDIR dist


#ready
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_PYTHON=python3
ENV SPARK_HOME=/spark-2.0.0/dist/bin	
CMD ["./bin/spark-class", "org.apache.spark.deploy.master.Master"]


