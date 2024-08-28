# dockerfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

- Docker of some Linux distribution
- [dotfiles](https://github.com/ToshikiNakamura0412/dotfiles_for_docker.git) is included in the image

## Installation
```bash
git clone https://github.com/ToshikiNakamura0412/dockerfiles.git ~/dockerfiles
~/dockerfiles/setup.sh
```

## Docker
### List
- [WIP] alpine3.17
- [WIP] debian
- [WIP] fedora
- humble
  - Ubuntu22.04 + ROS2 Humble
  - **Neovim is deprecated for ROS2 C/C++ development**
  - Please use VSCode
- noetic
  - Ubuntu20.04 + ROS1 Noetic
  - default shell: zsh
- noetic-cuda
  - Ubuntu20.04 + ROS1 Noetic + CUDA(devel)
  - default shell: zsh
- noetic-cuda-opencv
  - Ubuntu20.04 + ROS1 Noetic + CUDA(devel) + OpenCV
  - This is a different build procedure from the others, so please refer to [README.md](noetic-cuda-opencv/README.md)
  - default shell: zsh
- noetic-pcl10
  - Ubuntu20.04 + ROS1 Noetic + PCL10
  - This is a different build procedure from the others, so please refer to [README.md](noetic-pcl10/README.md)
  - default shell: zsh
- noetic-pcl14
  - Ubuntu20.04 + ROS1 Noetic + PCL14
  - This is a different build procedure from the others, so please refer to [README.md](noetic-pcl14/README.md)
  - default shell: zsh
- [WIP] opensuse
- ubuntu20.04
  - default shell: zsh
- ubuntu22.04
  - default shell: zsh

### workspace
- host:
  - default: `~/ws`
  - ROS1: `~/ros1_ws`
  - ROS2: `~/ros2_ws`
- container: `~/ws`

If you change base directory paths, please execute following command.
```bash
cd ~/dockerfiles
./change_root_dir.sh <new_root_dir>
./setup.sh
```

### Usage
If you do not have a GPU, comment out the deploy section in docker-compose.yml.

#### basic usage
```bash
cd <distro dir>
docker compose up [option -d]  # create and start
docker compose start           # start
docker compose stop            # stop
docker compose down            # stop and remove
```

#### use Shell
```bash
# bash (All Distro Support)
cd <distro dir>
docker compose exec ws bash

# zsh (Ubuntu Support)
cd <distro dir>
docker compose exec ws zsh
```

#### use VSCode
prerequisite: extension `ms-vscode-remote.remote-containers`
```bash
cd <distro dir>
code .
```
- Click on `Reopen in container` to run container
- If you don't click on `Reopen in container`, execute `~/install_vscode_extensions.sh` in the container to install the extension

## Recommendation
- It is recommended that you build the image provided and create an image based on it.
- Use `docker compose up` to check if the build is done correctly.

## References
- https://github.com/amslabtech/amsl_ros_docker_ws
