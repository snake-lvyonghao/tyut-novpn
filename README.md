# TYUT-novpn
![](https://img.shields.io/badge/version-1.0.0-green) [![GitHub stars](https://img.shields.io/github/stars/bla58351/tyut-novpn)](https://github.com/bla58351/tyut-novpn/stargazers)

在服务器上搭建MotionPro客户端，达到免连VPN访问tyut校园内网的目的  
[更新记录](#更新记录)
# 下载安装
ps:请全程在root环境下执行  
  
pps:本人仅在Ubuntu 18.04 LTS上测试通过，理论上CentOS也可使用，若出现安装及使用bug，请及时通过issue反馈。  
  
ppps:考虑到国内github访问不便，安装脚本内所有下载文件均使用`cloudflare workers`代理，若在你的设备上(多次)下载失败，请自行替换成可以使用的链接。  
  
现在，你可以通过直接执行下列命令来安装
```
wget -N --no-check-certificate https://github.com/bla58351/tyut-novpn/raw/master/install.sh && chmod +x install.sh && bash install.sh
```
之后，按照脚本提示输入相关信息，即可开始安装
# 食用脚本
没什么意外的话，执行`tyut`就能连接成功了  
若因用户名或密码错误导致连接失败，~~自行编辑`/usr/local/bin/tyut`开头的`username`和`password`字段~~ (临时) 可以重新执行安装程序来重新设置(未来可能会在安装脚本内提供修改功能)

# 脚本全部命令
`tyut`: 直接连接到VPN  
`tyut check`: 检测VPN及校园内网连接状态  
`tyut stop`: 断开VPN连接  
`tyut restart`: 重新连接VPN

# 未来计划
## 安装脚本
- [ ] 卸载tyut及MotionPro
- [ ] 更新脚本
- [ ] 修改tyut用户名及密码
- [ ] 查看详细信息
- [ ] 一键部署反向代理工具(如`nginx`)
## tyut
- [ ] 断线重连
- [ ] 就酱

# 更新记录

#### V1.1
- `install.sh`: (临时)当已经安装过MotionPro，将不再安装它

#### V1.0.0
- 写了一个简单的安装脚本
- 配合安装脚本，原`connect.sh`更名为`tyut`，并修改了一些提示

# bug反馈
若发现脚本使用时存在问题，如：服务器失联、连接失败等，可以发issue提交bug
