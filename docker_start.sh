# 1) create docker image under the directory that Dockerfile exists.
# docker build -t jwpyo_image_ubuntu:20210108 .

# 2) Create container based on the created image.

docker run -it -d \
	--privileged \
	-p 30033:22 \
	-p 30000:8888 \
	-p 30001:8080 \
	--shm-size=64G \
	--gpus all \
	-v /raid/workspace:/home/jungwoo_pyo/data \
	--name jwpyo_cont \
	-u jungwoo_pyo \
	jwpyo_image_ubuntu:20210108 \
	/bin/zsh install.sh

#docker run -it -d -p 30033:22 --name jwpyo_container jwpyo_image

# 3) container start
#docker start jwpyo_c

# 4) copy templates

docker cp vimrc_template jwpyo_cont:/home/jungwoo_pyo/.vimrc
docker cp screenrc_template jwpyo_cont:/home/jungwoo_pyo/.screenrc

# 5) connect as root inside container. You should set the passwd inside container
docker exec -it -u root jwpyo_cont /bin/zsh 

