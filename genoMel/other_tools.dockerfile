FROM ubuntu

USER root

WORKDIR ${HOME}

ENV http_proxy http://cloud-proxy:3128
ENV https_proxy http://cloud-proxy:3128
RUN apt-get update && apt-get install -y --force-yes \
    libpq-dev \
    openjdk-8-jre-headless \
    s3cmd \
    wget \
    unzip \
    fastqc \
    bedtools \
    bwa \
    samtools \
    vcftools \
    unzip \
    default-jdk \
    default-jre \
    make \
    g++ \
    python-pip \
    python-dev \
    python-setuptools \
    htslib-test \
    sudo \
    git

ENV PATH ${HOME}:${HOME}/snpEff/scripts:${HOME}/snpEff/galaxy:${HOME}/snpEff/galaxy/examples:${HOME}/vcflib/bin:${HOME}/apache-ant-1.9.7/bin:${HOME}/htslib/bin:$PATH

RUN sudo -E pip install Cython

RUN sudo -E wget https://github.com/samtools/htslib/archive/1.3.1.tar.gz; tar -zxf 1.3.1.tar.gz
WORKDIR ${HOME}/htslib-1.3.1/
RUN make
RUN make prefix=${HOME}/htslib install
WORKDIR ${HOME}

ENV C_INCLUDE_PATH ${HOME}/htslib/include
ENV LIBRARY_PATH ${HOME}/htslib/lib 
ENV LD_LIBRARY_PATH ${HOME}/htslib/lib

# COULD NOT GET DOCKER INSTALLATION OF PLATYPUS TO WORK _ INSTALLED MANUALLY
##RUN git clone https://github.com/andyrimmer/Platypus
##WORKDIR ${HOME}/tools/Platypus/
##RUN cp -r ${HOME}/tools/htslib/ ${HOME}/tools/Platypus/
##RUN make
# Get platypus here
# http://www.well.ox.ac.uk/bioinformatics/Software/Platypus-latest.tgz
# RUN wget http://www.well.ox.ac.uk/bioinformatics/Software/Platypus-latest.tgz
# tar -xvzf Platypus_0.8.1.tgz
###
#ADD Platypus_0.8.1 /root/tools/
#WORKDIR /root/tools/Platypus_0.8.1/
#RUN /root/tools/Platypus_0.8.1/buildPlatypus.sh
ADD Platypus-latest.tgz ${HOME}

ADD apache-ant-1.9.7 ${HOME}

RUN wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
RUN unzip snpEff_latest_core.zip
RUN rm snpEff_latest_core.zip

#RUN git clone --recursive https://github.com/vcflib/vcflib.git
#WORKDIR ${HOME}/vcflib/
#RUN make
WORKDIR ${HOME}

RUN git clone https://github.com/HuntsmanCancerInstitute/USeq

#docker build -f ./other_tools.dockerfile -t other_tools .

    
