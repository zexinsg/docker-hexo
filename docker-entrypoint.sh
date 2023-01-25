#!/bin/sh

WORKDIR=/hexo/
cd ${WORKDIR}

if [ "`ls -A $WORKDIR`" = "" ]; then
    echo ">>>>>>>>>>> 当前目录为空,初始化一个博客网站"
    hexo init ./
    echo ">>>>>>>>>>> 安装依赖和hexo插件"
    npm install
    npm install --save hexo-generator-searchdb \
        hexo-word-counter \
        hexo-generator-sitemap \
        hexo-server
    echo ">>>>>>>>>>> install next theme"
    git clone https://github.com/next-theme/hexo-theme-next.git themes/next
    sed -i 's/theme: landscape/theme: next/g' _config.yml
else
    echo ">>>>>>>>>> existed "
fi

hexo clean
hexo generate

hexo server -p ${HEXO_SERVER_PORT} -s
