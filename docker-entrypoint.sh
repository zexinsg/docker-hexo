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
    #echo ">>>>>>>>>>> install next theme"
    #git clone https://github.com/next-theme/hexo-theme-next.git themes/next
    #sed -i 's/theme: landscape/theme: next/g' _config.yml
    echo "install fluid theme"
    echo "github address https://github.com/fluid-dev/hexo-theme-fluid"
    npm install --save hexo-theme-fluid
    sed -i 's/theme: landscape/theme: fluid/g' _config.yml
    #fluid推荐使用，_config.fluid.yml 作为配置文件修改
    cp  _config.yml _config.fluid.yml
    #添加about页面
    hexo new page about
    sed -i '/title:/a\layout: about' source/about/index.md
else
    echo ">>>>>>>>>> existed "
fi

hexo clean
hexo generate

hexo server -p ${HEXO_SERVER_PORT} -s
