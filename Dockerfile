FROM jupyter/scipy-notebook:17aba6048f44
LABEL maintainer='Merelda Wu'

USER root

RUN apt-get update && apt-get install -y \
    vim \
    openjdk-11-jdk \
    libaio-dev \
    curl \
    gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install msodbcsql17 && \
    ACCEPT_EULA=Y apt-get install mssql-tools && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    source ~/.bashrc && \
    apt-get install unixodbc-dev 

ENV PATH "/usr/lib/jvm/java-11-openjdk:${PATH}"
WORKDIR /app
RUN pip install sqlalchemy-hana pyhdb python-dotenv pyodbc openpyxl && \
    pip install plotly cufflinks 

RUN jupyter labextension install jupyterlab_vim && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install @lckr/jupyterlab_variableinspector && \
    jupyter labextension install @jupyterlab/plotly-extension