# ROS Noetic XRDP
## Build
### build image `noetic-ws`
If you already build this image, skip this process.
```
cd ~/dockerfiles/noetic
docker compose build
```
### build image `noetic-xrdp-ws`
If you already build the image `noetic-ws`, please execute the following:
```
cd ~/dockerfiles/noetic-xrdp
docker compose build
```

## Usage
1. Start the containers
```
docker compose up -d
```

2. Connect to XRDP
   - Use a remote desktop client (e.g., Windows App)
   - Connect to `localhost:4389` (or the IP address of your Docker host if not running locally)
   - Login with username `user` and password `user`

### Tips
- Configure your remote desktop client for better experience:
   - Resolution (e.g., 1920x1080)
   - Color quality (e.g., 16 bit)
