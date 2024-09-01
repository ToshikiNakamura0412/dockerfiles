# dockerfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

- Docker of some Linux distribution
- [dotfiles](https://github.com/ToshikiNakamura0412/dotfiles.git) is included in the image
  - tmux prefix set to `C-q`

## Environment
### Architecture
- x86_64
- arm64

### Editor
- VSCode
- Neovim (Not support completion: ROS2)

## Prerequisites
- make

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
|   | Distro | Default Shell | Base Image | Contents | README |
|---|---|---|---|---|---|
| [humbe](humble) | Ubuntu22.04 | zsh | [ros (Official)](https://hub.docker.com/_/ros) | ROS2 Humble |  |
| [noetic](noetic) | Ubuntu20.04 | zsh | [ros (Official)](https://hub.docker.com/_/ros) | ROS1 Noetic |  |
| [noetic-cuda](noetic-cuda) | Ubuntu20.04 | zsh | [cuda (Official)](https://hub.docker.com/r/nvidia/cuda) | ROS1 Noetic + CUDA-11.6.1-devel |  |
| [noetic-cuda-opencv](noetic-cuda-opencv) | Ubuntu20.04 | zsh | noetic-cuda (Custom) | ROS1 Noetic + CUDA-11.6.1-devel + OpenCV-5.x | [README](noetic-cuda-opencv/README.md) |
| [noetic-pcl10](noetic-pcl10) | Ubuntu20.04 | zsh | noetic (Custom) | ROS1 Noetic + PCL10 | [README](noetic-pcl10/README.md) |
| [noetic-pcl14](noetic-pcl14) | Ubuntu20.04 | zsh | noetic (Custom) | ROS1 Noetic + PCL14 | [README](noetic-pcl14/README.md) |
| [ubuntu20.04](ubuntu20.04) | Ubuntu20.04 | zsh | [ubuntu (Official)](https://hub.docker.com/_/ubuntu) |  |  |
| [ubuntu22.04](ubuntu22.04) | Ubuntu22.04 | zsh | [ubuntu (Official)](https://hub.docker.com/_/ubuntu) |  |  |

### WIP
- [alpine3.17](alpine3.17)
- [debian](debian)
- [fedora](fedora)
- [opensuse](opensuse)

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
- https://github.com/amslabtech/amsl_ros_docker_ws
