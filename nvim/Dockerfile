FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
        ca-certificates curl wget git python3 python3-pip vim

RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
    tar zxf nvim-linux64.tar.gz && \
    mv nvim-linux64 /usr/local && \
    rm nvim-linux64.tar.gz
RUN echo 'export PATH=/usr/local/nvim-linux64/bin:$PATH' >> /root/.bashrc

RUN pip3 install setuptools
RUN pip3 install neovim

COPY init.vim /root/.config/nvim/init.vim
COPY dein.toml /root/.config/nvim/dein/toml/dein.toml
COPY dein_lazy.toml /root/.config/nvim/dein/toml/dein_lazy.toml

RUN curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
RUN sh ./installer.sh ~/.cache/dein

RUN /usr/local/nvim-linux64/bin/nvim +"call dein#install()" +qall; exit 0
RUN /usr/local/nvim-linux64/bin/nvim +"call dein#update()" +qall; exit 0
RUN /usr/local/nvim-linux64/bin/nvim +"UpdateRemotePlugins" +qall; exit 0
