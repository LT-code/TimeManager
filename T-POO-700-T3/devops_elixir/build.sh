#if [ -d "build" ]; then
  mkdir build
  mkdir build/front
  mkdir build/back

  cp ../../T-POO-700-T1/elixirproj_api/* build/back -r
  cp ../../T-POO-700-T2/miniproj/* build/front -r
  cp Dockerfile_back build/back/Dockerfile
  cp Dockerfile_front build/front/Dockerfile
  cp entrypoint_back.sh build/back/entrypoint.sh
  cp entrypoint_front.sh build/front/entrypoint.sh
  cp docker-compose.yml build
  cp .env build
  cp dev.exs build/back/config/

#fi

cd build

docker-compose up --build
#docker-compose start

#rm -r build
