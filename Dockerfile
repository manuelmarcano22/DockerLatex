FROM centos
MAINTAINER binet@cern.ch

##Basic image

RUN rpm -ivh --force http://ftp.scientificlinux.org/linux/scientific/7x/x86_64/os/Packages/sl-release-7.2-2.sl7.x86_64.rpm

ADD dot-bashrc                    /root/.bashrc
ADD dot-bash_profile              /root/.bash_profile

##Add repos. Example from slc 6
#ADD yum-repos-d-slc6-os.repo      /etc/yum.repos.d/slc6-os.repo
#ADD yum-repos-d-slc6-updates.repo /etc/yum.repos.d/slc6-updates.repo
#ADD yum-repos-d-slc6-extras.repo  /etc/yum.repos.d/slc6-extras.repo

RUN yum -y erase centos-release
RUN yum -y erase all
RUN yum -y distro-sync
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
	   bzip2 sudo passwd bc csh vim libXScrnSaver evince unzip \
	   perl-Tk perl-Digest-MD5

RUN yum -y install \
	   texlive-* 

#RUN yum -y install libxslt-devel libXt-devel zip

##TO install Anaconda with Python 3.4
#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh
#RUN /bin/bash ~/anaconda.sh -b -p /opt/conda && \
#    rm ~/anaconda.sh
#ENV PATH /opt/conda/bin:$PATH

##To install minicoda python 3.5
#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  -O ~/miniconda.sh && \
#    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#    rm ~/miniconda.sh
#RUN /opt/conda/bin/conda  install -y -c astropy python-cpl=0.7.2
#ENV PATH /opt/conda/bin:$PATH



##Add user called latex with sudo privilegies and passwd docker
RUN echo 'docker' | passwd root --stdin
RUN useradd -ms /bin/bash latex 
RUN usermod -aG wheel latex
RUN echo 'docker' | passwd vimos --stdin
USER latex
WORKDIR /home/latex
ENV HOME /home/latex



## EOF
