#docker build -t jwpyo_nvidiadriver:latest .

# docker run -it -d -p 30033:22 -v /hd4/jungwoo_pyo/jungwoo_pyo:/home/jungwoo_pyo --name jwpyo_container jwpyo_image
docker run -it -d -p 30033:22 --gpus all -v /hd4/table_recognition_dataset:/hd4/table_recognition_dataset --name jwpyo_container jwpyo_nvidiadriver
#docker run -it -d -p 30033:22 --name jwpyo_container jwpyo_image
docker start jwpyo_container
docker exec -it jwpyo_container /bin/zsh

