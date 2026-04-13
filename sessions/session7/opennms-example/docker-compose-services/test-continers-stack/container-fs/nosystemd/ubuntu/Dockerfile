# see https://www.cherryservers.com/blog/ssh-into-docker-container

FROM ubuntu:26.04
RUN apt-get update && apt-get install -y openssh-server whois sudo python3 python3-pip python3-venv
RUN mkdir -p /var/run/sshd


# Set root password for SSH access (change 'your_password' to your desired password)
# removed so only allowed login if ROOT_PASSWORD variable set
# RUN echo 'root:your_password' | chpasswd


RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22

# CMD ["/usr/sbin/sshd", "-D"]

# root password is passed in as an environment variable, used to set root password. This is not secure but works
CMD ["bash", "-c", "if [[ -v ROOT_PASSWORD ]]; then echo \"root:$ROOT_PASSWORD\" | chpasswd ;  fi && /usr/sbin/sshd -D"]


