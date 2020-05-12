FROM joyzoursky/python-chromedriver:3.8
COPY --from=openjdk:slim / /

ARG RELEASE=2.10.0
ARG ALLURE_REPO=https://dl.bintray.com/qameta/maven/io/qameta/allure/allure-commandline

RUN apt-get update
RUN apt-get install --no-install-recommends -y
RUN apt-get install wget -y
RUN apt-get install curl -y

RUN wget --no-verbose -O /tmp/allure-$RELEASE.zip $ALLURE_REPO/$RELEASE/allure-commandline-$RELEASE.zip \
  && unzip /tmp/allure-$RELEASE.zip -d / \
  && rm -rf /tmp/*

RUN apt-get remove --auto-remove wget -y
RUN chmod -R +x /allure-$RELEASE/bin

ENV JAVA_HOME=/usr/java/openjdk-13/
RUN export JAVA_HOME

ENV ALLURE_HOME=/allure-$RELEASE
ENV PATH=$PATH:$ALLURE_HOME/bin

WORKDIR /usr/src/app
