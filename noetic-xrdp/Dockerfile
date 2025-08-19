FROM noetic-ws

# Set user password
RUN echo "user:user" | sudo chpasswd

# Install XRDP
RUN git clone https://github.com/ToshikiNakamura0412/xrdp-xfce-setup.git ~/xrdp-xfce-setup
RUN ~/xrdp-xfce-setup/setup-xrdp.sh
