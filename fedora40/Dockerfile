FROM fedora:40
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN groupadd -g $USER_GID $USERNAME \
    && useradd -u $USER_UID -g $USERNAME $USERNAME \
    && dnf check-update || true \
    && dnf install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN dnf check-update || true && dnf upgrade -y
RUN dnf check-update || true && dnf install -y --setopt=install_weak_deps=False \
    bash-completion \
    tree \
    git \
    openssh-clients \
    cmake \
    @development-tools \
    python3 \
    python3-devel \
    python3-pip
RUN rm -rf /var/cache/dnf/*

USER $USERNAME
ENV SHELL /bin/bash
CMD ["/bin/bash"]

# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.bash
RUN ~/dotfiles/scripts/setup_tmux.bash C-q snow
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
