# 二维码批量生成工具，支持内嵌logo

##

## 安装

```sh
$: gem install qrcode-generator
```

## 环境依赖

1. 安装 [ImageMagick](http://www.imagemagick.org/script/binary-releases.php)

## 使用说明

### 简单示例
```bash
$: mkdir anEmptyFolder

$: cd anEmptyFolder

$: qrcode-generator init

$: qrcode-generator run

```

### 步骤说明

1. 打开命令行,创建一个空的目录并进入

2. 执行`qrcode-generator init`，这个命令会在当前目录中生成两个文件 --- links.txt 和 logo.png

      links.txt: 存放需要生成二维码的一些链接

      logo.png: 嵌入的品牌图标

3. 执行`qrcode-generator run`，这个命令会读取links.txt里的数据,并执行二维码生成操作，二维码存放在`qrcode <命令执行时间>`目录中

### 命令可选参数说明
```bash
$ qrcode-generator --help
```

