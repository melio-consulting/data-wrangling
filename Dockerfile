FROM jupyter/base-notebook:python-3.8.6
LABEL maintainer='Merelda Wu'

USER root

RUN apt-get update && apt-get install -y \
    vim \
    openjdk-11-jdk \
    libaio-dev \
    curl \
    gnupg

WORKDIR /app

COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

RUN jupyter labextension install \
    @axlair/jupyterlab_vim \
    @jupyterlab/toc \
    @lckr/jupyterlab_variableinspector

