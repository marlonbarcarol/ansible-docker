
.PHONY: \
	default \
	docker.build \
	docker.stop \
	docker.run \
	docker.srun \
	ansible.ping \
	ansible.playbook.nginx \
	ansible.check.webpage

.DEFAULT: default

default: docker.build docker.srun ansible.ping ansible.playbook.nginx ansible.check.webpage

docker.build:
	@docker build -f ./infrastructure/Dockerfile -t alpine-ssh ./infrastructure

docker.stop:
	@[ "$$(docker ps -q)" ] && docker stop $$(docker ps -q) || ( :; )

docker.run:
	docker run \
		--name=alpine-ssh \
		--rm \
		-itd \
		-p 2222:2222 \
		-p 80:80 \
		-v $(PWD)/infrastructure/key/id_rsa.pub:/root/.ssh/authorized_keys \
		alpine-ssh

docker.srun:
	@$(MAKE) docker.stop
	@sleep 0.2
	@$(MAKE) docker.run

ansible.ping:
	ansible -i hosts webserver_docker -m ping

ansible.ping.all:
	ansible -i hosts all -m ping

ansible.playbook.nginx:
	ansible-playbook -i hosts alpine-nginx-playbook.yml

ansible.check.webpage:
	ansible -i hosts webserver_docker -m uri -a 'url=http://localhost return_content=yes'
