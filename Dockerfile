FROM nvidia/cuda:11.0-devel-ubuntu18.04
MAINTAINER Jungwoo Pyo <jungwoo_pyo@tmax.co.kr>
ARG user=jungwoo_pyo
#centos7 library
RUN apt-get update && apt-get -y install sudo gcc vim git curl wget zsh tmux locales openssh-server

# create user
RUN useradd -m $user
USER $user

# save file in host directly, not container
VOLUME ["/raid/DLA"]
WORKDIR "/home/${user}"
COPY install.sh .
COPY vimrc_template ./.vimrc

#oh-my-zsh installation
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

CMD ["/bin/zsh"]

EXPOSE 22 80 443 6666 8080 8888 30000 30001 30002 30003 30004 30005 30006 30007 30008 30009 30010
