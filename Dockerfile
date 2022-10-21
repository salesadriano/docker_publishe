From debian

WORKDIR /projeto

RUN apt-get -y update && \
    apt-get -y install ca-certificates curl gnupg lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get -y update && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    apt-get -y install docker-ce-cli git && \
    apt-get autoremove && \
    apt-get clean