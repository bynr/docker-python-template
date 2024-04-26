FROM python:3.11-slim-buster
RUN apt-get -qq update \
        && apt-get -qq install --no-install-recommends --no-install-suggests -y \
        bash \
        curl \
        jq \
        ca-certificates \
        zip \
        build-essential \
        git \
        gnupg \
        openssh-client
RUN curl -L -o shfmt \
        https://github.com/mvdan/sh/releases/download/v3.1.2/shfmt_v3.1.2_linux_amd64 \
        && chmod 0700 shfmt \
        && mv shfmt /usr/bin

COPY pyproject.toml /etc/
COPY requirements.txt .
RUN pip install -r requirements.txt
WORKDIR /workspace
ENV PYTHONPATH /workspace/src
