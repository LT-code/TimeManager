mkdir build
cp ../../T-POO-700-T1/nodejs_api/* ./build -r
#docker build -t tm_devops .
docker-compose build
rm -r build
