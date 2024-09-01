FROM fedora:latest
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
# RUN dnf check-update || true && dnf install -y \
#     cmake \
#     make \
#     automake \
#     gcc \
#     gcc-c++ \
#     kernel-devel \
#     python3 \
#     python3-devel \
#     python3-pip \
#     curl \
#     tree \
#     git \
#     clang
ENV SHELL /bin/bash

USER $USERNAME

CMD ["/bin/bash"]
