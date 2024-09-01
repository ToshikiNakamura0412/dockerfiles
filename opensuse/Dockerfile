FROM opensuse/leap:latest
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
# RUN zypper refresh && zypper install -y \
#     cmake \
#     python3 \
#     python3-devel \
#     python3-pip \
#     curl \
#     tree \
#     git \
#     clang
# RUN zypper install -y --type pattern devel_basis
ENV SHELL /bin/bash

USER $USERNAME

CMD ["/bin/bash"]
