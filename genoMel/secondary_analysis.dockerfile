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

RUN mkdir ${HOME}/tools

ADD docker/GenomeAnalysisTK.jar ${HOME}/tools/

WORKDIR ${HOME}/tools/

RUN wget https://github.com/broadinstitute/picard/releases/download/1.126/picard-tools-1.126.zip \
    && git clone https://github.com/broadinstitute/picard.git \
    && mv ${HOME}/tools/picard/src ${HOME}/ \
    && unzip picard-tools-1.126.zip \
    && mv picard-tools-1.126 picard-tools \
    && rm *.zip

WORKDIR ${HOME}

# Phillis created this dockerfile on the genoMel test VM on 5-3-16q
