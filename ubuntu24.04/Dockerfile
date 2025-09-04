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
    ca-certificates \
    cmake \
    build-essential \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv

RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/apt/apt.conf.d/docker-clean

USER ${USERNAME}
ENV HOME=/home/${USERNAME}
RUN python3 -m venv $HOME/venv && \
    $HOME/venv/bin/python3 -m pip install --upgrade pip setuptools wheel
ENV PATH="$HOME/venv/bin:$PATH"
ENV SHELL /bin/bash
CMD ["/bin/bash"]


# Use dotfiles
RUN git clone --recursive --single-branch --depth 1 https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.bash
RUN ~/dotfiles/scripts/setup_tmux.bash C-q snow
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
