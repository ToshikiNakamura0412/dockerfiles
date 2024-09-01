# dockerfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

- Docker of some Linux distribution
- [dotfiles](https://github.com/ToshikiNakamura0412/dotfiles.git) is included in the image
  - tmux prefix set to `C-q`

## Environment
### Architecture
- x86_64
- arm64

## Installation
### Clone
Please clone to your home directory
```bash
git clone https://github.com/ToshikiNakamura0412/dockerfiles.git ~/dockerfiles
```

### Setup
#### Default
create directories (e.g. [workspace](#workspace))
```bash
cd ~/dockerfiles
make setup
```
#### Custom
```bash
cd ~/dockerfiles
make [target] [arg=<arg>]
...
make setup
```
- show help of make: `make help`
- show help of target: `make [target] arg=-h`
  - target: `change_root_dir`, `disable_gpu`, `select_shell`, `setup`, `sync_git_user`

## Clean
- remove directories (e.g. [workspace](#workspace)) and revert to the default state
  - **If the directories are not empty, they will not be deleted**
```bash
cd ~/dockerfiles
make clean
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

### Usage
#### basic usage
```bash
cd <distro dir>
docker compose up [option -d]  # create and start (-d: detached)
docker compose start           # start
docker compose stop            # stop
docker compose down            # stop and remove
```

If you want to create different containers for the same environment, do the following:
```bash
docker compose -p <project name> up [option -d]
```

#### use Shell
```bash
cd <distro dir>
docker compose exec ws <shell>  # bash, zsh
```
- bash: All Distro Support
- zsh: Only Ubuntu Support

#### use VSCode
prerequisite: extension `ms-vscode-remote.remote-containers`
```bash
cd <distro dir>
code .
```
- Click on `Reopen in container` to run container
- If you don't click on `Reopen in container`, execute `~/install_vscode_extensions.sh` in the container to install the extension

## Recommendation
- If you are creating a new IMAGE, it is recommended that you build the provided image and create an image based on it.
- Use `docker compose up` to check if the build is done correctly.

## References
- https://github.com/amslabtech/amsl_ros_docker_ws
