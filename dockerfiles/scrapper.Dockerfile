FROM maes95/jupyter:basic

RUN pip install --upgrade pip

RUN apk add docker && apk update

RUN echo "jupyter-notebook --notebook-dir=/home/notebooks --ip='0.0.0.0' --port=8888 --NotebookApp.token=\$1 --allow-root" > /home/startNotebook.sh \
    && chmod +x /home/startNotebook.sh

ENV PIP_PACKAGE beautifulsoup4 testcontainers[selenium] nbzip

RUN pip install ${PIP_PACKAGE}

RUN jupyter serverextension enable --py nbzip --sys-prefix \
    && jupyter nbextension install --py nbzip \
    && jupyter nbextension enable --py nbzip

# DEFAULT RUN: NO TOKEN
CMD ["sh", "/home/startNotebook.sh"]  -v /var/run/docker.sock:/var/run/docker.sock --privileged=true

# BUILD docker build  -f dockerfiles/scrapper.Dockerfile -t maes95/jupyter:scrapper .
# RUN docker run -d --rm --name jupyter-scrapper -p 8888:8888 -v $PWD/notebooks/:/home/notebooks/ -v /var/run/docker.sock:/var/run/docker.sock --privileged=true maes95/jupyter:scrapper
