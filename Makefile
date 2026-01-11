COMPOSE=docker compose
COMPOSE_FILE="./srcs/docker-compose.yml"

all:
	sudo mkdir -p /home/aoo/data/mariadb
	sudo mkdir -p /home/aoo/data/wordpress
	sudo $(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	sudo $(COMPOSE) -f $(COMPOSE_FILE) down

clean:
	sudo $(COMPOSE) -f $(COMPOSE_FILE) down -v

reload: down all

rmi:
	sudo docker image prune -a

fclean: clean rmi
	sudo rm -rf /home/aoo/data
	
re: fclean all

.PHONY: all down clean fclean re