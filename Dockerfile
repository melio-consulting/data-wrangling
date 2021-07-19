FROM jupyter/scipy-notebook:lab-3.0.16

LABEL maintainer='Merelda Wu'

USER root

RUN apt-get update && apt-get install -y \
    curl 

WORKDIR app

COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
