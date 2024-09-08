# dockerfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

![image](https://github.com/ToshikiNakamura0412/dockerfiles/wiki/images/dockerfiles.png)

- Development environment using Docker for [some Linux distributions](#docker)
- You can use GUI applications without setting up xhost.
- [dotfiles](https://github.com/ToshikiNakamura0412/dotfiles.git) is included in the image
  - tmux prefix set to `C-q`

## Environment
### Architecture
- x86_64
- arm64

### Editor
- VSCode
- Neovim (Not support completion: ROS2)
  - CentOS Stream: Not support Neovim. Please use Vim.

## Prerequisites
### Common
- make
- [docker](https://docs.docker.com/engine/install/ubuntu/#installation-methods)

### GPU
#### Use
- nvidia-container-runtime
  - If you can't install this package, install [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-apt) before installing this package.
  - If you can't use GPU, execute the following command:
    ```bash
    sudo systemctl restart docker
    ```
#### Not use
- Please disable GPU by [custom](#custom) setup

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
make setup # create directories
```
#### Custom
```bash
cd ~/dockerfiles
make [target] [arg=<arg>]
...
make setup # create directories
```
- show help of make: `make help`
- show help of target: `make [target] arg=-h`
  - target: `change_root_dir`, `disable_gpu`, `select_shell`, `setup`, `sync_git_user`

**If you already start the container, you need to execute the following command to reflect the changes.**
```bash
docker compose up [option -d]
```

## Clean
- remove directories (e.g. [workspace](#workspace)) and revert to the default state
  - **If the directories are not empty, they will not be deleted**
```bash
cd ~/dockerfiles
make clean
```

## Docker
|   | Distro | Default Shell | Base Image | Contents | README |
|---|---|---|---|---|---|
| [alpine3.17](alpine3.17) | Alpine3.17 | zsh | [alpine (Official)](https://hub.docker.com/_/alpine) |  |  |
| [archlinux](archlinux) | ArchLinux | zsh | [archlinux (Official)](https://hub.docker.com/_/archlinux) |  |  |
| [centos-stream9](centos-stream9) | CentOS Stream9 | zsh | [centos (Official)](https://quay.io/repository/centos/centos) |  |  |
| [debian12](debian12) | Debian12 | zsh | [debian (Official)](https://hub.docker.com/_/debian) |  |  |
| [fedora40](fedora40) | Fedora40 | zsh | [fedora (Official)](https://hub.docker.com/_/fedora) |  |  |
| [humbe](humble) | Ubuntu22.04 | zsh | [ros (Official)](https://hub.docker.com/_/ros) | ROS2 Humble |  |
| [noetic](noetic) | Ubuntu20.04 | zsh | [ros (Official)](https://hub.docker.com/_/ros) | ROS1 Noetic |  |
| [noetic-cuda](noetic-cuda) | Ubuntu20.04 | zsh | [cuda (Official)](https://hub.docker.com/r/nvidia/cuda) | ROS1 Noetic + CUDA-11.6.1-devel |  |
| [noetic-cuda-opencv](noetic-cuda-opencv) | Ubuntu20.04 | zsh | noetic-cuda (Custom) | ROS1 Noetic + CUDA-11.6.1-devel + OpenCV-5.x | [README](noetic-cuda-opencv/README.md) |
| [noetic-pcl10](noetic-pcl10) | Ubuntu20.04 | zsh | noetic (Custom) | ROS1 Noetic + PCL10 | [README](noetic-pcl10/README.md) |
| [noetic-pcl14](noetic-pcl14) | Ubuntu20.04 | zsh | noetic (Custom) | ROS1 Noetic + PCL14 | [README](noetic-pcl14/README.md) |
| [opensuse-leap15.6](opensuse-leap15.6) | OpenSUSE Leap15.6 | zsh | [opensuse/leap (Official)](https://hub.docker.com/r/opensuse/leap) |  |  |
| [ubuntu20.04](ubuntu20.04) | Ubuntu20.04 | zsh | [ubuntu (Official)](https://hub.docker.com/_/ubuntu) |  |  |
| [ubuntu22.04](ubuntu22.04) | Ubuntu22.04 | zsh | [ubuntu (Official)](https://hub.docker.com/_/ubuntu) |  |  |

Alpine does not yet support nvidia-container-runtime

### Workspace
- host:
  - default: `~/ws`
  - ROS1: `~/ros1_ws`
  - ROS2: `~/ros2_ws`
- container:
  - all: `~/ws`

### Usage
#### Basic usage
```bash
cd <target image dir>
docker compose up [option -d]  # create and start (-d: detached)
docker compose start           # start
docker compose stop            # stop
docker compose down            # stop and remove
```

If you want to create different containers of the same environment, execute the following:
```bash
docker compose -p <project name> up [option -d]
```

#### Use Shell
```bash
cd <target image dir>
docker compose exec ws <command> # e.g. zsh, bash, tmux
```
- bash: All Distro Support
- zsh: Only Ubuntu Support

#### Use VSCode
prerequisite: extension `ms-vscode-remote.remote-containers`
```bash
cd <target image dir>
code .
```
- Click on `Reopen in container` to run container
- If you don't click on `Reopen in container`, execute `~/install_vscode_extensions.sh` in the container to install the extension

## Recommendation
- If you are creating a new IMAGE, it is recommended that you build the provided image and create an image based on it.
- Use `docker compose up` to check if the build is done correctly.

## References
- https://docs.ros.org/en/rolling/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container.html
