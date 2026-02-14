# parent docker file https://github.com/semaphoreui/semaphore/blob/v2.17.0/deployment/docker/server/Dockerfile

FROM semaphoreui/semaphore:v2.17.0

USER root

RUN apk add --no-cache  sudo nano
    
# see https://github.com/semaphoreui/semaphore/blob/develop/deployment/docker/server/Dockerfile
# The graphical login managers do not show users with UID below 1000

ARG SEMAPHORE_USER="semaphore"
ARG ANSIBLE_USER="ansible"
ARG ANSIBLE_PASSWORD="minad1234"

RUN adduser --disabled-password --gecos ""  $ANSIBLE_USER 

RUN echo "$ANSIBLE_USER:$ANSIBLE_PASSWORD" | chpasswd

RUN echo "$ANSIBLE_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$ANSIBLE_USER && chmod 0440 /etc/sudoers.d/$ANSIBLE_USER

RUN echo "$SEMAPHORE_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$SEMAPHORE_USER && chmod 0440 /etc/sudoers.d/$SEMAPHORE_USER

# back to original user
USER 1001  


