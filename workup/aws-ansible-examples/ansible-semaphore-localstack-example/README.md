# ansible semaphore example

## semaphore


https://semaphoreui.com/

see https://docs.semaphoreui.com/administration-guide/installation/docker/

UI at http://localhost:3000

SEMAPHORE_ADMIN_PASSWORD: changeme 

SEMAPHORE_ADMIN_NAME: admin

## localstack

some references:

Note that localstack will not create aws simulation without localstack-pro

[A guide to LocalStack with docker-compose](https://medium.com/@muthomititus/a-guide-to-localstack-with-docker-compose-e1487e3a776f)

[Using LocalStack with Docker Compose to mock AWS services.](https://whattodevnow.medium.com/using-localstack-with-docker-compose-to-mock-aws-services-bb25a5b01d4b)   
This shows how to Here you mount a setup file so it will be executed when the localstack container starts

localstack ui missing depricated 
https://stackoverflow.com/questions/57554575/localstack-cant-access-dashboard

https://linuxtechlab.com/install-localstack-gui-interface-for-local-aws-part-2/   using localstack pro  - SHOULD ALL OW Ui but doent work


# aws cli docker

The AWS Command Line Interface (AWS CLI) is an open source tool that enables you to interact with AWS services using commands in your command-line shell. 
It can be installed directly on your host machine or as in this example, run as a docker container

[AWS CLI Getting Started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-docker.html)

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-proxy.html   Using an HTTP proxy for the AWS CLI


## test machines
ideally we could use  linux as test container. 

THere are two test containers provided with SSH access but with NO SYSTEMD

so what we can do with these and Ansible is limited.

getting systemd to run in docker is problematic but can be done when using podman

some discussion here https://developers.redhat.com/blog/2019/04/24/how-to-run-systemd-in-a-container#

There are system d containers here - but problems trying to run in docker desktop !!.

https://hub.docker.com/r/antmelekhin/docker-systemd/tags?name=almalinux

https://github.com/antmelekhin/docker-systemd/tree/main

## clone this repo into semaphore container ansible account

```
docker compose up -d

docker compose exec semaphore bash

sudo su - ansible # this logs in as ansible with correct path

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/ansible-aws-example

```
# better ssh-add command
see https://stackoverflow.com/questions/33055819/automate-ssh-add-passphrase-using-expect

Here is a better way to automate it.

Create a script (e.g. ps.sh with executable flags) which prints your passphrase, e.g.:
```
#!/bin/sh
echo 'my_passphrase'
Then specify this script via SSH_ASKPASS variable, so it can be used for the authentication, e.g. :

```
$ cat id_rsa | SSH_ASKPASS=./ps.sh ssh-add -

```

