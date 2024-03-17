NAME = inception

all:
	@printf "Launch configuration ${NAME}...\n"
	@chmod +x srcs/requirements/wordpress/tools/create-dir.sh
	@bash srcs/requirements/wordpress/tools/create-dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${NAME}...\n"
	@chmod +x srcs/requirements/wordpress/tools/create-dir.sh
	@bash srcs/requirements/wordpress/tools/create-dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re:
	@printf "Rebuild configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${NAME}...\n"
	@docker system prune -a
	@rm -rf /home/olahmami/data/

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@rm -rf /home/olahmami/data/

.PHONY	: all build down re clean fclean
