FROM openjdk
MAINTAINER Steven <steven.vandenberghe@sirris.be>

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0.tgz && tar xvzf spark-2.0.0.tgz
WORKDIR spark-2.0.0
COPY pom.xml .
RUN ./dev/make-distribution.sh --name spark-swift -Phadoop-2.4 -Pyarn -Phive -Phive-thriftserver
WORKDIR dist
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_PYTHON=python3
CMD ["./bin/spark-class", "org.apache.spark.deploy.master.Master"]


