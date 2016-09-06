FROM openjdk
MAINTAINER steven.vandenberghe@sirris.be
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0.tgz && tar xvzf spark-2.0.0.tgz
WORKDIR spark-2.0.0
COPY pom.xml .
RUN ./build/mvn -Phadoop-2.7 -Dhadoop.version=2.7.0 -Phive -Phive-thriftserver -Pyarn -DskipTests clean package
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]

