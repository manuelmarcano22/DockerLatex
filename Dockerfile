FROM centos
MAINTAINER binet@cern.ch

##Basic image

#RUN rpm -ivh --force http://ftp.scientificlinux.org/linux/scientific/7x/x86_64/os/Packages/sl-release-7.2-2.sl7.x86_64.rpm
#
#
#RUN yum -y erase centos-release
#RUN yum -y erase all
#RUN yum -y distro-sync
#ENV HOME /root

##Extra
RUN yum -y update
RUN yum -y install \
           file which

RUN yum -y install binutils-devel gcc gcc-c++ gcc-gfortran git make patch python-devel \
	   glibc.i686 zlib.i686 ncurses-libs.i686 bzip2-libs.i686 uuid.i686 libxcb.i686 \
	   libXmu.so.6 libncurses.so.5 tcsh


#These are needed to build IRAF

RUN yum -y install \
           bzip2-devel \
           libXpm-devel libXft-devel libXext-devel \
           libxml2-devel \
           libuuid-devel \
           ncurses-devel \
           texinfo \
           wget \
	   bzip2 sudo passwd bc csh vim-X11 libXScrnSaver evince

Run yum -y install texlive texlive-latex texlive-xetex texlive-collection-latex \
	texlive-collection-latexrecommended \
	texlive-collection-latexextra

##Add user called latex with sudo privilegies and passwd docker
RUN echo 'docker' | passwd root --stdin
RUN useradd -ms /bin/bash latex 
RUN usermod -aG wheel latex
RUN echo 'docker' | passwd latex --stdin
USER latex
ENV HOME /home/latex
WORKDIR /home/latex
RUN git clone https://github.com/manuelmarcano22/config-files.git
WORKDIR /home/latex/config-files
RUN bash setup.sh

WORKDIR /home/latex




