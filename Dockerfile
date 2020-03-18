FROM ubuntu:18.04
MAINTAINER Jungwoo Pyo <jungwoo_pyo@tmax.co.kr>


RUN apt-get update && apt-get -y install sudo vim git curl wget zsh screen locales
RUN useradd -m jungwoo_pyo && echo "jungwoo_pyo:abcd1234!" | chpasswd && adduser jungwoo_pyo sudo
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
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8



CMD ["/bin/zsh"]

EXPOSE 22 80 443 8080
