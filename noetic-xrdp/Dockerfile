FROM noetic-ws

ARG USERNAME=user

# Set user password
RUN echo "${USERNAME}:${USERNAME}" | sudo chpasswd

# Change default shell
RUN sudo usermod -s /bin/bash ${USERNAME}

# Install XRDP
RUN git clone https://github.com/ToshikiNakamura0412/xrdp-xfce-setup.git ~/xrdp-xfce-setup
RUN ~/xrdp-xfce-setup/setup-xrdp.sh
