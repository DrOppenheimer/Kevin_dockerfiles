FROM quay.io/jeremiahsavage/cdis_base

USER root
ENV http_proxy http://cloud-proxy:3128
ENV https_proxy http://cloud-proxy:3128
RUN apt-get update && apt-get install -y --force-yes \
    libpq-dev \
    openjdk-8-jre-headless \
    s3cmd \
    wget \
    unzip

USER ubuntu

ENV HOME /home/ubuntu

RUN sudo -E apt-get install -y cmake

RUN mkdir ${HOME}/tools

ADD GenomeAnalysisTK.jar ${HOME}/tools/

WORKDIR ${HOME}/tools/

RUN sudo -E git clone --recursive https://github.com/ekg/freebayes.git

WORKDIR ${HOME}/tools/freebayes
RUN make
 
WORKDIR ${HOME}/tools/

RUN wget https://github.com/chapmanb/bcbio.variation/releases/download/v0.2.6/bcbio.variation-0.2.6-standalone.jar

ENV PATH ${HOME}/tools:${HOME}/tools/freebayes/bin:$PATH

WORKDIR ${HOME}

