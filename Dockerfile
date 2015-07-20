# NGS STAR IMAGE

# base image
FROM ubuntu:14.04

# Maintainer 
MAINTAINER Tobias Meissner "meissner.t@googlemail.com"

# update system
RUN apt-get update &&  apt-get upgrade -y && apt-get dist-upgrade -y 

# install some system tools
RUN apt-get install -y g++ make wget zlib1g-dev

#--------------STAR ALIGNER ----------------------------------------------------------------------------------------------#
# https://github.com/alexdobin/STAR

RUN cd /opt && \
    wget -c -P /opt/star https://github.com/alexdobin/STAR/archive/STAR_2.4.2a.tar.gz && \
    tar -xzf /opt/star/STAR_2.4.2a.tar.gz -C /opt/star && \
    make STAR -C /opt/star/STAR-STAR_2.4.2a/source
    
#---------------------------------------------------------------------
#Cleanup the temp dir
RUN rm -rvf /tmp/*

#open ports private only
EXPOSE 8080

# Use baseimage-docker's bash.
CMD ["/bin/bash"]

#Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ 
    
#Add star to PATH
ENV PATH /opt/star/STAR-STAR_2.4.2a/bin/Linux_x86_64:$PATH
