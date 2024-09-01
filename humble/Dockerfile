ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-desktop \
    python3-colcon-common-extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    tree \
    git \
    openssh-client
RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/apt/apt.conf.d/docker-clean

USER $USERNAME
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ~/ws/install/local_setup.bash" >> ~/.bashrc
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashr
RUN echo "export ROS_WORKSPACE=~/ws" >> ~/.bashrc
RUN echo "export _colcon_cd_root=\$ROS_WORKSPACE" >> ~/.bashrc
ENV SHELL /bin/bash
CMD ["/bin/bash"]


# Use dotfiles
RUN git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.sh
RUN ~/dotfiles/scripts/change_tmux_conf.sh C-q snow
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.zsh" >> ~/.zshrc
RUN echo "source ~/ws/install/local_setup.zsh" >> ~/.zshrc
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh" >> ~/.zshrc
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.zshrc
RUN echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.zshrc
RUN echo "export ROS_WORKSPACE=~/ws" >> ~/.zshrc
RUN echo "export _colcon_cd_root=\$ROS_WORKSPACE" >> ~/.zshrc
RUN echo 'eval "$(register-python-argcomplete3 ros2)"' >> ~/.zshrc
RUN echo 'eval "$(register-python-argcomplete3 colcon)"' >> ~/.zshrc
ENV SHELL /bin/zsh
CMD ["/bin/zsh"]
