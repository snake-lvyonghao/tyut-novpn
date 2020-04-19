#!/usr/bin/env bash
sh_ver="1.0.0"
MotionPro_ver="1.2.6"
MotionPro_file="/usr/bin/MotionPro"
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
line="——————————————————————————————"
check_root() {
    [[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1
}
check_sys() {
    if [[ -f /etc/redhat-release ]]; then
        release="centos"
    elif cat /etc/issue | grep -q -E -i "ubuntu"; then
        release="ubuntu"
    elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
        release="centos"
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
        release="centos"
    fi
    bit=$(uname -m)
}
check_update() {
    sh_new_ver=$(wget --timeout=1 --no-check-certificate -qO- "https://github-mirror.mygddown.workers.dev/https://github.com/bla58351/tyut-novpn/raw/master/install.sh" | grep 'sh_ver="' | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1)
    [[ -z ${sh_new_ver} ]] && echo -e "${Error} 检测最新版本失败 !"
    if [[ -n ${sh_new_ver} && ${sh_new_ver} != ${sh_ver} ]]; then
        echo -e "${Red_font_prefix}发现新版本[ ${sh_new_ver} ],推荐前往https://github.com/bla58351/tyut-novpn更新${Font_color_suffix}"
    fi
}
check_status() {
    if [[ -f ${MotionPro_file} ]]; then
        echo -e "MotionPro状态:${Green_font_prefix}已安装${Font_color_suffix}"
    else
        echo -e "MotionPro状态:${Green_font_prefix}未安装${Font_color_suffix}"
    fi
}
update_shell() {
    # TODO: 更新脚本
    echo haha
}
install() {
    if [[ -f ${MotionPro_file} ]]; then
        echo -e "${Info} 你已经安装过MotionPro了" && exit 1
    else
        read -p "请输入你的校园网登录用户名：" user
        read -s -p "请输入你的校园网登录密码：" password
        echo -e "${Info} 正在安装MotionPro"
        if [ ${release} == 'ubuntu' ]; then
            apt update && apt install -y sudo vim curl wget
            system="Ubuntu"
        else
            yum install -y sudo vim curl wget
            system="CentOS"
        fi
        wget --no-check-certificate "https://github-mirror.mygddown.workers.dev/https://github.com/bla58351/tyut-novpn/raw/master/src/MotionPro_Linux_${system}_x64_v${MotionPro_ver}.sh"
        if [ $? -eq 0 ]; then
            sh ./MotionPro_Linux_${system}_x64_v${MotionPro_ver}.sh
            if [[ -f ${MotionPro_file} ]]; then
                echo -e "${Info} MotionPro安装成功"
                rm ./MotionPro_Linux_${system}_x64_v${MotionPro_ver}.sh
            else
                echo -e "${Error} MotionPro安装失败" && exit 1
            fi
        else
            echo -e "${Error} 下载MotionPro安装包失败，可以稍后重试安装" && exit 1
        fi
        echo -e "${Info} 正在安装tyut"
        wget --no-check-certificate "https://github-mirror.mygddown.workers.dev/https://github.com/bla58351/tyut-novpn/raw/master/tyut" && chmod +x tyut
        if [ $? -eq 0 ]; then
            sed -i "2i\username=${user}\npassword=${password}\n" tyut
            mv tyut /usr/local/bin
            if [ $? -eq 0 ]; then
                # clear
                echo -e "${Info} tyut安装成功，你可以在 https://github.com/bla58351/tyut-novpn/blob/master/README.md 查阅使用方法"
            else
                echo -e "${Error} tyut安装失败" && exit 1
            fi
        else
            echo -e "${Error} 无法下载tyut文件" && exit 1
        fi
    fi
}
main() {
    check_sys
    check_root
    [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1
    [[ ${bit} != "x86_64" ]] && echo -e "${Error} 本脚本不支持非x64系统" && exit 1
    check_update
    echo -e "  MotionPro搭建脚本 ${Green_font_prefix}[v${sh_ver}]${Font_color_suffix}
$line
  ${Green_font_prefix}1.${Font_color_suffix} 开始搭建
  ${Green_font_prefix}2.${Font_color_suffix} 退出程序
 "
    check_status
    echo && read -p "请输入数字 [1-2]：" num
    case "$num" in
    1)
        install
        ;;
    2)
        exit 0
        ;;
    *)
        echo -e "${Error} 请输入正确的数字 [1-2]"
        ;;
    esac
}
main
