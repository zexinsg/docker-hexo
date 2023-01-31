#!/bin/sh

WORKDIR=/hexo/
cd ${WORKDIR}

if [ "`ls -A $WORKDIR`" = "" ]; then
    echo ">>>>>>>>>>> 当前目录为空,初始化一个博客网站"
    hexo init ./
    echo ">>>>>>>>>>> 安装依赖和hexo插件"
    npm install
    npm install --save hexo-generator-searchdb \
	hexo-blog-encrypt \
        hexo-word-counter \
        hexo-generator-sitemap \
	hexo-generator-baidu-sitemap \
	hexo-generator-index \
        hexo-server
    echo "hexo-generator-index 用于文章置顶功能 Front-matter 中配置 sticky 属性,可以让文章首页前排显示,sticky 数值越大，该文章越靠前"
    echo "hexo-blog-encrypt 用于文章加密"
    #echo ">>>>>>>>>>> install next theme"
    #git clone https://github.com/next-theme/hexo-theme-next.git themes/next
    #sed -i 's/theme: landscape/theme: next/g' _config.yml
    echo "install fluid theme"
    echo "github address https://github.com/fluid-dev/hexo-theme-fluid"
    npm install --save hexo-theme-fluid
    sed -i 's/theme: landscape/theme: fluid/g' _config.yml
    #fluid推荐使用，_config.fluid.yml 作为配置文件修改
    cp  _config.yml _config.fluid.yml
    #post的文章模板修改，添加categories
    sed -i '/^tags:.*/a\categories:' scaffolds/post.md
    #添加about页面
    hexo new page about
    sed -i '/title:/a\layout: about' source/about/index.md
    # post_asset_folder: 设置为true, 创建目录的同事会创建一个同名的asset目录
    sed -i '/^post_asset_folder.*/c\post_asset_folder: true' _config.fluid.yml
    #关闭fluid主题的默认代码line number
    sed -i 's/line_number: true/line_number: false/' node_modules/hexo-theme-fluid/_config.yml
else
    echo ">>>>>>>>>> existed "
fi

hexo clean
hexo generate

hexo server -p ${HEXO_SERVER_PORT} -s
