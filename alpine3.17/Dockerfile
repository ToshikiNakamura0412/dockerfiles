FROM alpine:3.17
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup -g $USER_GID -S $USERNAME \
    && adduser -SD -u $USER_UID -G $USERNAME $USERNAME \
    && apk update \
    && apk add sudo bash \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && echo "$USERNAME:$USERNAME" | chpasswd \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apk update && apk upgrade
RUN apk update && apk add --no-cache \
    bash-completion \
    tree \
    git \
    openssh-client \
    cmake \
    build-base \
    python3 \
    python3-dev \
    py3-pip
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN rm -rf /var/cache/apk/*

USER $USERNAME
ENV SHELL /bin/bash
CMD ["/bin/bash"]


# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.bash
RUN ~/dotfiles/scripts/setup_tmux.bash C-q snow
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
