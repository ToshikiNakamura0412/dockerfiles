FROM noetic-cudnn-ws

# opencv installation
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    wget \
    unzip \
    libgtk2.0-dev \
    pkg-config
RUN cd ~/ \
    && wget -O opencv.zip https://github.com/opencv/opencv/archive/5.x.zip \
    && unzip opencv.zip \
    && cd opencv-5.x \
    && cmake -S . -B build \
    && cmake --build build \
    && cd build \
    && sudo make install \
    && rm ~/opencv.zip
