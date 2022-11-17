# Ansible playground

## Requirements

- Docker
- Ansible

A macOS environment is assumed.

## Configuration

### SSH configuration
This allows us to run simpler ssh command targeting our docker container, removing the need to specify user, port and ssh key. 
Essentially making `ssh -p 2222 -i infrastructure/key/id_rsa root@localhost` into `ssh localhost`.

```zsh
sudo -- sh -c -e '
touch /etc/ssh/ssh_config.d/custom_config &&
grep "Host localhost" /etc/ssh/ssh_config.d/custom_config || echo "
Host localhost
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    User root
    IdentityFile $PWD/infrastructure/key/id_rsa
    Port 2222" >> /etc/ssh/ssh_config.d/custom_config'
```

### Ansible configuration

```zsh
# Had to manually create ~/.ansible.cfg
ansible-config init --disabled > ~/.ansible.cfg
```

## Build the docker image, run container, trigger ansible tasks and nginx playbook

```zsh
make
```

## Makefile

The Makefile is used as a place to store commands, so it is easier to remember when coming back. Please use it as a reference.
e.g. `make docker.build docker.run ansible.ping`
