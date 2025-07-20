FROM ubuntu:24.04
ARG USERNAME=ubuntu

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update && \
    apt-get install -y sudo && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}
RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    tree \
    git \
    openssh-client \
    cmake \
    build-essential \
    python3 \
    python3-dev \
    python3-pip
RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/apt/apt.conf.d/docker-clean

USER ${USERNAME}
ENV SHELL /bin/bash

# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.bash
RUN ~/dotfiles/scripts/setup_tmux.bash C-q snow

CMD ["/bin/bash"]
