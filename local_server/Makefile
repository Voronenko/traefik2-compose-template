update-certs:
	curl -sLo ./traefik_certs/fiksim_privkey.pem https://github.com/Voronenko/fiks.im/releases/download/$(shell curl -s https://api.github.com/repos/Voronenko/fiks.im/releases/latest | grep tag_name | cut -d '"' -f 4)/fiksim_privkey.pem
	curl -sLo ./traefik_certs/fiksim_cert.pem https://github.com/Voronenko/fiks.im/releases/download/$(shell curl -s https://api.github.com/repos/Voronenko/fiks.im/releases/latest | grep tag_name | cut -d '"' -f 4)/fiksim_cert.pem
	curl -sLo ./traefik_certs/fiksim_fullchain.pem https://github.com/Voronenko/fiks.im/releases/download/$(shell curl -s https://api.github.com/repos/Voronenko/fiks.im/releases/latest | grep tag_name | cut -d '"' -f 4)/fiksim_fullchain.pem

create-traefik-network-once:
	docker network create --attachable  traefik-public
up:
	docker-compose up -d
down:
	docker-compose down


swarm-create-traefik-network-once:
	docker network create --driver=overlay --attachable  traefik-public

swarm-up:
	docker stack deploy --compose-file=docker-compose.yml traefik
swarm-down:
	docker stack rm traefik
