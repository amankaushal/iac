FROM amankaushal/opscidemo:base 
LABEL version="3.12"
ENV DEPLOY_DIR="/deployer"
ENV TF_VER="0.14.11"
ENV PIP_VER="22.0.4"
ENV ANSIBLE_VER="2.11.9"
ENV PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/home/int_user/.local/bin
USER root

RUN apk add --no-cache \
    ca-certificates \
    bash \
    jq \
    git \
    curl \
    unzip \
    tar \
    libgit2 \
    openssl-dev \
    libffi-dev \
    gcc \
    musl-dev \
    python2-dev \
    make \
    openssh \
    tini \
    shadow \
    su-exec \
    wget \
    python3 \
    python3-dev \
    py-pip

WORKDIR ${DEPLOY_DIR}
ADD . ${DEPLOY_DIR}

RUN  curl -O https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip && \
  unzip -o terraform_${TF_VER}_linux_amd64.zip -d /bin && rm terraform_${TF_VER}_linux_amd64.zip

RUN chown -R int_user:int_user ${DEPLOY_DIR}

USER int_user

RUN pip3 install --upgrade pip==${PIP_VER} && \
  pip3 install -r requirements.txt

CMD ["/bin/bash"]
