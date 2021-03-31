FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
# install anaconda 5.2.0
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


RUN apt-get install zip unzip
RUN apt-get update

# install pytorch 1.1 and cudatoolkit
RUN conda install pytorch==1.1.0 torchvision==0.3.0 cudatoolkit=10.0 -c pytorch

# clone and install openvqa dependencies
RUN mkdir /workspace && \
    cd /workspace && \    
    git clone https://github.com/linjieli222/VQA_ReGAT.git && \
    cd /VQA_ReGAT
    
RUN conda env create -f /tools/environment.yml

# Activate the environment, and make sure it's activated:
RUN conda activate vqa

RUN /bin/bash -c "source /tools/download.sh"

