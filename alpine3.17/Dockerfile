FROM alpine:3.17
ARG USERNAME=user

RUN addgroup -S $USERNAME \
    && adduser -S $USERNAME -G $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "$USERNAME:$USERNAME" | chpasswd
RUN apk update && apk add bash sudo git vim tzdata
RUN apk update && apk upgrade
# RUN apk update && apk add \
#     cmake \
#     build-base \
#     python3 \
#     python3-dev \
#     py3-pip \
#     tree
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV SHELL /bin/bash

USER $USERNAME

# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.sh
RUN ~/dotfiles/scripts/change_tmux_conf.sh C-q snow

CMD ["/bin/bash"]
