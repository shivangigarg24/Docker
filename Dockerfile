FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
# install anaconda 5.2.0
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get install -y wget

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


RUN apt-get install zip unzip
RUN apt-get install nano
RUN apt-get install -y gedit
RUN apt-get update

# clone and install openvqa dependencies
RUN mkdir /workspace && \
    cd /workspace && \    
    git clone https://github.com/shivangigarg24/VQA_ReGAT.git && \
    cd VQA_ReGAT
    
RUN conda env create -f /workspace/VQA_ReGAT/tools/environment.yml

# Activate the environment, and make sure it's activated:
#CMD ["conda", "run", "-n", "v"]
RUN /bin/bash -c "source activate vqa"
#RUN /bin/bash -c "source /workspace/VQA_ReGAT/tools/download.sh"

