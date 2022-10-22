From docker

RUN apk update && \
    apk add git && \
    ssh-keygen -N -y -f /root/.ssh/id_rsa