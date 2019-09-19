docker_img_name=t3_bootstrap
export docker_img_name

docker build -t $docker_img_name .
docker run -it $docker_img_name
