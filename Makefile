DOCKER_COMPOSE = docker-compose


.PHONY: sysdeps
sysdeps:
	sudo apt-get install qemu binfmt-support qemu-user-static


.PHONY: deps
deps:
	pipenv install


.PHONY: build
build:
	${DOCKER_COMPOSE} build


.PHONY: run
run:
	${DOCKER_COMPOSE} up --scale server=3


.PHONY: test
test:
	${MAKE} -C console test


.PHONY: load
load: deps
	xdg-open http://0.0.0.0:8089
	pipenv run locust --host=http://test_host.shanty.local:8080/
