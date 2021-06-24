FROM --platform=linux/x86_64 ubuntu:20.04

WORKDIR /work

SHELL ["/bin/bash", "-c"]

RUN apt list --upgradable
RUN apt update

RUN apt install -y build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev git wget

RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv

# pyenv
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
ENV PATH $PYENV_ROOT/shims:${PATH}

# Install Python and set default
RUN pyenv install 3.7.4
RUN pyenv global 3.7.4

# Install pipenv
RUN pip install pipenv

RUN pipenv install \
flake8 \
jupyter \
jupyterlab \
kaggle \
matplotlib \
numpy \
pandas \
pep8 \
scikit-learn \
scipy \
seaborn \
signate \
sympy \
xgboost \
Pillow
# tqdm \
# jupyter_contrib_NbExtensions \
# jupyter_nbextensions_configurator \


RUN pipenv run jupyter notebook --generate-config

RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py

# 以下、イメージ作成からjupyter起動まで

# イメージ作成
# docker build . -t hogeimage

# コンテナ起動、バインドもいれてみた
# docker run -itd -p 127.0.0.1:8888:8888 -v  C:/Users/hoge/ab:/work --name hogecontainer hogeimage

# docker exec -it hogecontainer bash の後、ここにあるコマンドを実行してjupyterを開く

# コンテナ下でjupyterを開く
# pipenv run jupyter notebook --port 8888 --allow-root

# これでパッケージインストールしたかった
# COPY ./Pipfile /
# RUN pipenv install sync
