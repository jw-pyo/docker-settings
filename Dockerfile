FROM ubuntu:18.04
MAINTAINER Jungwoo Pyo <jungwoo_pyo@tmax.co.kr>

#CUDA driver
RUN apt-get update && apt-get install -y --no-install-recommends \
gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl && \
rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 10.2.89

ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
cuda-compat-10-2 && \
ln -s cuda-10.2 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.2 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419"


RUN apt-get update && apt-get -y install sudo vim git curl wget zsh screen locales openssh-server
RUN useradd -m jungwoo_pyo && echo "jungwoo_pyo:abcd1234!" | chpasswd && adduser jungwoo_pyo sudo

# sshd install
RUN echo "abcd1234!" | sudo -S service ssh start
# RUN echo "abcd1234!" | sudo -S chmod 755 .oh-my-zsh .zsh*

USER jungwoo_pyo

# save file in host directly, not container
# VOLUME ["/hd4/jungwoo_pyo/jungwoo_pyo"]
VOLUME ["/hd4/table_recognition_dataset"]
WORKDIR "/home/jungwoo_pyo"

#anaconda installation
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
RUN sh Anaconda3-2020.02-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.02-Linux-x86_64.sh
ENV PATH /home/jungwoo_pyo/anaconda3/bin:$PATH

RUN conda update conda && conda update anaconda && conda update --all
RUN conda install -y tensorflow 

#oh-my-zsh installation
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#locale
RUN echo "abcd1234!" | sudo -S locale-gen en_US.UTF-8
RUN echo "abcd1234!" | sudo -S update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8



CMD ["/bin/zsh"]

EXPOSE 22 80 443 8080
