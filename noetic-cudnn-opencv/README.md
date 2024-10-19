# ROS Noetic cuDNN OpenCV
## build
### build image `noetic-cudnn-ws`
If you already build this image, skip this process.
```
cd ~/dockerfiles/noetic-cudnn
docker compose build
```
### build image `noetic-cudnn-opencv-ws`
If you already build the image `noetic-cudnn-ws`, please execute the following:
```
cd ~/dockerfiles/noetic-cudnn-opencv
docker compose build
```
