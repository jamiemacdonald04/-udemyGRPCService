FROM  jenkins/jenkins:lts-jdk11
USER root

RUN apt-get update
RUN apt install dirmngr --install-recommends
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
RUN echo "deb https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list
RUN apt-get update
RUN apt-get -y install k6
RUN apt-get -y install vim

COPY /K6 /var/K6
COPY /proto /var/proto


