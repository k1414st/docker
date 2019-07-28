FROM nvidia/cuda:latest

# RUN mv /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/cuda.list.bak && \
#     mv /etc/apt/sources.list.d/nvidia-ml.list /etc/apt/sources.list.d/nvidia-ml.list.bak && \
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        vim wget sudo procps git curl file make xz-utils patch unzip bzip2 make cifs-utils \
        gcc g++ build-essential python-dev python3-dev \
        language-pack-ja fonts-ipafont fonts-ipaexfont libboost-dev nkf \
        mecab libmecab-dev mecab-ipadic-utf8 \
        python-pydot python-pydot-ng graphviz && \
    apt-get autoremove

RUN mkdir downloads && \
    mkdir -p /usr/lib/x86_64-gnu/mecab/dic && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git downloads/mecab-ipadic-neologd && \
    yes yes| downloads/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd && \
    sed -i -e 's/\/var\/lib\/mecab\/dic\/debian/\/usr\/lib\/x86_64-linux-gnu\/mecab\/dic\/mecab-ipadic-neologd/' etc/mecabrc && \
    rm -rf downloads/*

RUN wget -q https://repo.continuum.io/archive/Anaconda3-2019.03-Linux-x86_64.sh -P ./downloads/&& \
    bash ./downloads/Anaconda3-2019.03-Linux-x86_64.sh -b && \
    chmod 755 /root && \
    rm ./downloads/Anaconda3-2019.03-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH

RUN conda install -y jupyter tensorflow-gpu keras pydotplus graphviz pystan luigi && \
    conda clean --all -y
RUN pip install --no-cache-dir tensorflow_probability==0.6 dtreeviz mecab-python3 optuna lightgbm fbprophet plotly mlxtend

RUN git clone https://github.com/k1414st/keras_extension /keras_extension
WORKDIR /keras_extension
RUN python setup.py install
WORKDIR /

RUN git clone https://github.com/lambdalisue/jupyter-vim-binding \
        /root/anaconda3/share/jupyter/nbextensions/vim_binding
RUN pip install jupyter_contrib_nbextensions

ARG USERNAME=jupyter
RUN useradd -m -s /bin/bash ${USERNAME}
RUN gpasswd -a ${USERNAME} sudo
RUN echo "${USERNAME}:${USERNAME}" | chpasswd
USER ${USERNAME}
ENV PATH /root/anaconda3/bin:$PATH

RUN jupyter notebook --generate-config && \
    jupyter contrib nbextension install --user && \
    mkdir -p /home/${USERNAME}/jupyter-working/saved && \
    sed -i.back \
        -e "s:^#c.NotebookApp.token = .*$:c.NotebookApp.token = u'':" \
        -e "s:^#c.NotebookApp.ip = .*$:c.NotebookApp.ip = '*':" \
        -e "s:^#c.NotebookApp.open_browser = .*$:c.NotebookApp.open_browser = False:" \
        -e "s:^#c.NotebookApp.notebook_dir = .*$:c.NotebookApp.notebook_dir = '/home/${USERNAME}/jupyter-working':" \
    /home/${USERNAME}/.jupyter/jupyter_notebook_config.py

WORKDIR /home/${USERNAME}
