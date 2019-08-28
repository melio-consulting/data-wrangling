FROM gcr.io/kubeflow-images-public/tensorflow-1.13.1-notebook-cpu:v-base-08f3cbc-1166369568336121856
#FROM jupyter/scipy-notebook:2ce7c06a61a1

USER root

RUN apt-get update && apt-get install -y \
        libaio-dev \
        curl \
        gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /home/jovyan/.bash_profile && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /home/jovyan/.bashrc && \
    apt-get install -y unixodbc-dev

RUN pip install sqlalchemy python-dotenv pyodbc openpyxl plotly cufflinks

RUN conda install nodejs

RUN jupyter labextension install jupyterlab_vim && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install @lckr/jupyterlab_variableinspector && \
    jupyter labextension install @jupyterlab/plotly-extension

ENV NB_PREFIX /

CMD ["sh","-c", "jupyter lab --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
