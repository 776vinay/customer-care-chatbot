FROM python:3.8-slim-bullseye AS BASE

RUN apt-get update \
    && apt-get --assume-yes --no-install-recommends install \
        build-essential \
        curl \
        git \
        jq \
        libgomp1 \
        python3-dev \
        gcc \
        g++ \
        libc6-dev \
        libffi-dev \
        libssl-dev \
        pkg-config \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# upgrade pip version
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Install Rasa with specific constraints to avoid dependency conflicts
RUN pip install --no-cache-dir --no-deps rasa==2.8.1 || \
    pip install --no-cache-dir rasa==2.8.1 --use-deprecated=legacy-resolver

ADD config.yml config.yml
ADD domain.yml domain.yml
ADD credentials.yml credentials.yml
ADD endpoints.yml endpoints.yml