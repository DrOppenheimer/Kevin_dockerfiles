FROM quay.io/jeremiahsavage/cdis_base

USER root
ENV http_proxy http://cloud-proxy:3128
ENV https_proxy http://cloud-proxy:3128
RUN apt-get update && apt-get install -y --force-yes \
    libpq-dev \
    openjdk-8-jre-headless \
    python-dev \
    pkg-config \ 
    wget \
    unzip \
    libpng-dev \
    libfreetype6-dev \
    python-numpy python-scipy \
    python-matplotlib

USER ubuntu
ENV HOME /home/ubuntu

RUN mkdir ${HOME}/tools

RUN pip install -e git+https://github.com/brwnj/bcl2fastq.git@master#egg=bcl2fastq 

ADD Trimmomatic-0.36 ${HOME}/tools 

ADD novocraft ${HOME}/tools

WORKDIR ${HOME}/tools/

RUN wget https://github.com/broadinstitute/picard/releases/download/1.126/picard-tools-1.126.zip \
    && git clone https://github.com/broadinstitute/picard.git \
    && mv ${HOME}/tools/picard/src ${HOME}/ \
    && unzip picard-tools-1.126.zip \
    && mv picard-tools-1.126 picard-tools \
    && rm *.zip

ENV PATH ${HOME}/tools:$PATH

WORKDIR ${HOME}
