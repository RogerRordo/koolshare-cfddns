# koolshare-cfddns

## 简介 

这是一个适用于梅林固件(koolshare) 的 [CloudFlare](https://www.cloudflare.com/) DDNS 插件，基于 [gdddns](https://github.com/mritd/koolshare-gdddns) 修改而来

## 插件使用

* 固件版本为   **380.70-X7.9.1** 的，请使用 cfddns 1.1.1 版本
* 固件版本低于 **380.70-X7.9.1** 的，请使用 cfddns 1.0.0 版本

CloudFlare参数列表

参数名|示例|备注
--|--|--
API Key|c2547eb745079dac9320b638f5e225cf483cc5cfdda41|Global API Key
Email|user@example.com|账户邮箱
Zone Id|023e105f4ecef8ad9ca31a8372d0c353|域名ID
Record ID|372e67954025e0ba6aaa6d586b9e0b59|DNS记录ID

* 使用 cURL 获取 **Zone ID** 

```cmd
curl -X GET "https://api.cloudflare.com/client/v4/zones" \
	-H "Content-Type: application/json" \
	-H "X-Auth-Key: $API_KEY" \
  -H "X-Auth-Email: $EMAIL"
```

响应中的 id 即为 `Zone ID`

```json
{
	"result": [{
		"id": "023e105f4ecef8ad9ca31a8372d0c353", //Zone ID
  }],
  //......
}
```

* 使用 cURL 获取 **DNS Record ID**

```cmd
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Content-Type: application/json" \
     -H "X-Auth-Key:$API_KEY" \
     -H "X-Auth-Email:$EMAIL"
```

在响应中找到目标域名对应的 id 

```json
{
	"result": [{
		"id": "$RECORD_ID1",
		"zone_id": "$ZONE_ID",
		"zone_name": "$example.com",
		"name": "test1.example.com", // 具体域名1
		"type": "A",
    //......
	}, {
		"id": "$RECORD_ID2",
		"zone_id": "$ZONE_ID",
		"zone_name": "$example.com",
		"name": "test2.example.com", // 具体域名2
		"type": "A",
	}]
	//......      
}
```





## 下载

[cfddns](https://github.com/geek5nan/koolshare-cfddns/releases)

## 安装

在软件中心使用离线安装方式安装