FROM openjdk
MAINTAINER steven.vandenberghe@sirris.be
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0.tgz && tar xvzf spark-2.0.0.tgz
WORKDIR spark-2.0.0
COPY pom.xml .
RUN ./dev/make-distribution.sh --name spark-swift -Phadoop-2.4 -Phive -Phive-thriftserver -Pyarn
WORKDIR dist
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_PYTHON=python3
CMD ["./bin/spark-class", "org.apache.spark.deploy.master.Master"]

