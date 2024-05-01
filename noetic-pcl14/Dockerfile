FROM noetic-ws
ARG PCL_VERSION=1.14.0

# pcl installation
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    wget \
    unzip \
    pcl-tools
RUN cd ~/ \
    && wget -O pcl.zip https://github.com/PointCloudLibrary/pcl/archive/refs/tags/pcl-${PCL_VERSION}.zip \
    && unzip pcl.zip \
    && cd pcl-pcl-${PCL_VERSION} \
    && cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build \
    && cd build \
    && sudo make install \
    && rm ~/pcl.zip
