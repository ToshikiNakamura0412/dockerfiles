FROM archlinux:latest
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && pacman -Syu --noconfirm \
    && pacman -S --noconfirm sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm \
    bash-completion \
    tree \
    git \
    openssh \
    cmake \
    base-devel \
    python \
    python-pip
RUN pacman -Scc --noconfirm

USER $USERNAME
ENV SHELL /bin/bash
CMD ["/bin/bash"]


# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.bash
RUN ~/dotfiles/scripts/setup_tmux.bash C-q snow
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
