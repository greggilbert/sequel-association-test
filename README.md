To run:

1. docker-compose build && docker-compose up -d
2. docker exec -it $(docker ps -lq) /bin/sh

Once MySQL is running (might take a few seconds):

3. sequel -m migrations/ mysql2://sequeltest:sequeltest@db/sequeltest
4. ruby setup.rb
5. ruby doit.rb
