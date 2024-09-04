FROM opensuse/leap:15.6
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN groupadd -g $USER_GID $USERNAME \
    && useradd -u $USER_UID -g $USER_GID -m $USERNAME \
    && zypper refresh \
    && zypper install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN zypper refresh && zypper update -y
RUN zypper refresh && zypper install -y --no-recommends \
    bash-completion \
    tree \
    git \
    openssh-clients \
    cmake \
    patterns-devel-base-devel_basis \
    python3 \
    python3-devel \
    python3-pip
RUN rm -rf /var/cache/zypp/*

USER $USERNAME
ENV SHELL /bin/bash
CMD ["/bin/bash"]


# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.sh
RUN ~/dotfiles/scripts/change_tmux_conf.sh C-q snow
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
