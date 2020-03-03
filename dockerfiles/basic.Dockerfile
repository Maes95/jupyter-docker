FROM alpine:3.8

RUN apk update && \
    apk add --no-cache python3 && \
    pip3 install --upgrade --no-cache-dir pip setuptools && \
    ln -s /usr/bin/python3 /usr/bin/python

RUN apk add --no-cache build-base python3-dev zeromq-dev freetype-dev libpng-dev && \
    pip install --no-cache-dir jupyter matplotlib 

RUN mkdir -p /home/notebooks
WORKDIR /home/notebooks

# DEFAULT RUN: NO TOKEN
CMD ["jupyter-notebook","--notebook-dir=/home/notebooks","--ip='0.0.0.0'","--NotebookApp.token=''","--port=8888"]

# BUILD docker build -f dockerfiles/basic.Dockerfile -t maes95/jupyter:basic .
# RUN docker run -d --rm --name jupyter-scrapper -p 8888:8888 -v $PWD/notebooks/:/home/notebooks/ maes95/jupyter:basic