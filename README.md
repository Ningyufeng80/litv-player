# LiTV Player - 直播源生成器  
这是一个 LiTV 直播源生成器，支持台湾多个电视频道的 M3U 播放列表生成。 
## 使用方法
获取完整 M3U 列表
http://your-domain/litv2.php?token=cnbkk  
获取单个频道 M3U8
http://your-domain/litv2.php?token=cnbkk&id=4gtv-4gtv009  
环境变量
变量名,说明,默认值
PORT,服务端口,8080
PASSWORD,密码,见 .env.example
ADMIN_USER,管理员用户名,admin
ADMIN_PASS,管理员密码,123456
LITV_GENERATOR_HOST,生成器主机,service-6969a53504512dd9764ebb83
支持的频道

新闻频道：中天新闻、TVBS新闻、东森新闻等

综合频道：民视、台视、中视、华视等

娱乐频道：TVBS欢乐、民视综艺等

电影频道：靖天电影、龙华电影等

戏剧频道：靖天戏剧、龙华戏剧等

体育频道：博斯运动、智林体育等

其他频道：儿童、音乐、教育等

## 功能特性
- 支持 100+ 台湾电视频道
- 生成 M3U 播放列表
- 支持单频道 M3U8 流获取
- 完整的 Nginx + PHP-FPM 配置
- 支持大文件上传和长时间连接  
## 部署方式  
### 在 Zeabur 上部署
1. 连接你的 GitHub 仓库到 Zeabur
2. 选择此仓库进行部署
3. 配置环境变量（参考 `.env.example`）
4. 部署完成后访问服务  
### 本地部署  
```bash  
docker build -t litv-player .  
docker run -p 8080:8080 litv-player  
