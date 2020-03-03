FROM playniuniu/jupyter-pandas

WORKDIR /home/notebooks

VOLUME /home/notebooks

# DEFAULT RUN: NO TOKEN
CMD ["jupyter-notebook" "--notebook-dir=/home/notebooks" "--ip='0.0.0.0'" "--port=8888" "--NotebookApp.token=''" "--allow-root"]

# BUILD docker build  -t maes95/jupyter:scrapper .
# RUN docker run -d --rm --name jupyter-scrapper -p 8888:8888 -v $PWD/notebooks/:/home/notebooks/ maes95/jupyter:scrapper