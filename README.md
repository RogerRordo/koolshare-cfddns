# koolshare-cfddns

## 简介 

> 这是一个适用于梅林固件(koolshare) 的 CloudFlare DDNS 插件，基于 [GodaddyDDNS](https://github.com/mritd/koolshare-gdddns) 修改

## 插件使用

- 首先自己的域名需要托管在 CloudFlare
- 在 [CloudFlare](https://dash.cloudflare.com/profile) 网站上生成用于调用 CloudFlare API 的 Key
- 安装本插件，填入参数即可

### CloudFlare参数列表

参数名|示例|备注
--|--|--
API Key|c2547eb745079dac9320b638f5e225cf483cc5cfdda41|账户API Key
Email|user@example.com|账户邮箱
Zone Id|023e105f4ecef8ad9ca31a8372d0c353|域名ID
Record ID|372e67954025e0ba6aaa6d586b9e0b59|DNS记录ID
