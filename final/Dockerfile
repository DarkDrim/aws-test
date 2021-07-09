FROM centos:7

RUN yum update -y && \
yum install -y wget && \
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
yum clean all

ENV HOME /root
WORKDIR /root
COPY scripts/calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar .

CMD ["bash"]
