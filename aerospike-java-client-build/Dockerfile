FROM centos:7

RUN yum updateinfo && \
yum -y install install java-1.8.0-openjdk
RUN yum -y install maven && \
yum -y install git

RUN git clone https://github.com/aerospike/aerospike-client-java && \
cd aerospike-client-java && \
./build_all

# Build stage 2.
# This stage pulls the compiled JavaScript code from the stage 1 intermediate image.
# This stage builds the final Docker image that we'll use in production.
#
FROM centos:7

RUN yum updateinfo && \
yum -y install install java-1.8.0-openjdk

RUN mkdir -p /aerospike-client-java/benchmarks/target
COPY run-forever.sh /
RUN chmod 755 /run-forever.sh
COPY --from=0 /aerospike-client-java/benchmarks/run_benchmarks /aerospike-client-java/benchmarks/run_benchmarks_copy
COPY --from=0 /aerospike-client-java/benchmarks/target/aerospike-benchmarks-*-jar-with-dependencies.jar /aerospike-client-java/benchmarks/target
RUN echo "#!/bin/bash" > /aerospike-client-java/benchmarks/run_benchmarks && \
tail -n 2 /aerospike-client-java/benchmarks/run_benchmarks_copy >> /aerospike-client-java/benchmarks/run_benchmarks && \
chmod 755 /aerospike-client-java/benchmarks/run_benchmarks && \
rm /aerospike-client-java/benchmarks/run_benchmarks_copy

WORKDIR /aerospike-client-java/benchmarks

CMD /run-forever.sh
