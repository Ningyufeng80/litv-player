# LiTV Player - 直播源生成器  
这是一个 LiTV 直播源生成器，支持台湾多个电视频道的 M3U 播放列表生成。  
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
