FROM ubuntu

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
    python-numpy\
    python-scipy \
    python-matplotlib\
    python-pandas\
    python-sympy\
    python-nose\
    python-pip\
    sudo\
    git

#USER ubuntu
#ENV HOME /home/ubuntu
    
RUN mkdir ${HOME}/tools

RUN pip install -e git+https://github.com/brwnj/bcl2fastq.git@master#egg=bcl2fastq 

ADD Trimmomatic-0.36 ${HOME}/tools 

ADD novocraft ${HOME}/tools

WORKDIR ${HOME}/tools/

RUN sudo -E wget https://github.com/broadinstitute/picard/releases/download/1.126/picard-tools-1.126.zip \
    && sudo -E git clone https://github.com/broadinstitute/picard.git \
    && mkdir -p ${HOME}/tools/picard/src
    && cp ${HOME}/tools/picard/src ${HOME}/ \
    && unzip picard-tools-1.126.zip \
    && cp picard-tools-1.126 picard-tools \
    && rm *.zip

ENV PATH ${HOME}/tools:/home/ubuntu/src/bcl2fastq:/home/ubuntu/.local/lib/python2.7/site-packages/matplotlib:$PATH

WORKDIR ${HOME}

# FROM quay.io/jeremiahsavage/cdis_base
