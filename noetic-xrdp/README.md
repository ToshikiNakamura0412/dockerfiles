# ROS Noetic XRDP

![image](https://github.com/ToshikiNakamura0412/xrdp-xfce-setup/wiki/images/demo.png)

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
- To keep your display number fixed, when logging out, do not press the X button. Instead, go to [user] -> [Log Out...] -> [uncheck “Save session for logins”] -> [Log Out].
   - Otherwise, a zombie session (new display) will be created each time you restart.
