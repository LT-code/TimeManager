FROM node:latest

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Install app dependencies
COPY build/package.json /app
RUN npm install

# Bundle app source
COPY build /app

EXPOSE 4000 5432

# db creation
#ENV PGPASSWORD='root'
#RUN psql -U postgres -c 'CREATE DATABASE tmaapp_dev'


#CMD ["npm", "install"]
CMD [ "npm", "start" ]
