ARG NODE_VERSION=16

FROM node:${NODE_VERSION}-bullseye
RUN export DEBIAN_FRONTEND=noninteractive && \
    export DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt update && apt upgrade -y && \
    apt install git vim rsync -y && \
    update-alternatives --set editor /usr/bin/vim.basic && \
    vim_version=$(ls /usr/share/vim/ |egrep "vim[0-9]{2,3}"); \
    for vim_setting in ${vim_version};do \
        sed -i 's/set mouse=a/set mouse=""/' /usr/share/vim/${vim_version}/defaults.vim; \
        sed -i '/set tabstop/cset tabstop=4 shiftwidth=4 expandtab' /usr/share/vim/${vim_version}/defaults.vim; \
    done && \
    echo ":set encoding=utf-8" >> /root/.vimrc && \
    echo ":set fileencodings=utf-8" >> /root/.vimrc && \
    echo ":set termencoding=utf-8" >> /root/.vimrc && \
    echo "LANG=C.UTF-8" >> /root/.bashrc && \
    npm install hexo-cli -g && \
    mkdir /hexo
RUN echo PS1="'"'\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\ \033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"'" >> /root/.bashrc
RUN echo alias ls="'"'ls --color=auto'"'" >> /root/.bashrc
WORKDIR /hexo
#ENV LANG=C.UTF-8
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
