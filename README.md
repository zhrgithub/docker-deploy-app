# Docker 部署应用集合

使用 Docker 快速部署各种常用应用和服务的配置集合。

## 📋 当前部署服务列表

### 1. ELK Stack (Elasticsearch + Logstash + Kibana)
- **版本**: 8.13.4
- **服务组件**:
  - **Elasticsearch**: 端口 9200，单节点模式，禁用安全认证
  - **Logstash**: 端口 5044, 9600，配置心跳监测和日志处理
  - **Kibana**: 端口 5601，数据可视化界面
- **用途**: 日志收集、分析和可视化
- **启动命令**: `cd elk && docker-compose up -d`

### 2. RocketMQ 消息队列
- **版本**: Apache RocketMQ 5.1.0
- **服务组件**:
  - **NameServer**: 端口 9876，注册中心
  - **Broker**: 端口 10911, 10909，消息代理，异步主节点配置
  - **Dashboard**: 端口 8082，Web管理界面
- **用途**: 分布式消息队列服务
- **启动命令**: `cd rocket-mq && docker-compose up -d`

### 3. Nginx Web服务器
- **配置**: 自定义配置文件
- **服务功能**:
  - 静态文件服务（端口 80）
  - 打印演示站点配置
  - 安全头配置（X-Frame-Options, X-XSS-Protection等）
  - 静态资源缓存优化
  - API代理预留配置
- **用途**: Web服务器和反向代理
- **启动命令**: `docker run -d -p 80:80 -v $(pwd)/nginx/conf/nginx.conf:/etc/nginx/nginx.conf nginx`

### 4. MySQL 8 数据库
- **配置**: 预留配置目录结构
- **状态**: 配置文件待完善
- **用途**: 关系型数据库服务

## 🚀 快速开始

1. 克隆项目：
```bash
git clone <repository-url>
cd docker-deploy-app
```

2. 选择需要的服务进入对应目录启动：
```bash
# 启动ELK Stack
cd elk && docker-compose up -d

# 启动RocketMQ
cd rocket-mq && docker-compose up -d

# 启动Nginx (需要手动运行docker命令)
docker run -d -p 80:80 -v $(pwd)/nginx/conf/nginx.conf:/etc/nginx/nginx.conf nginx
```

3. 访问服务：
   - Kibana: http://localhost:5601
   - RocketMQ Dashboard: http://localhost:8082
   - Nginx Demo: http://localhost

## 📝 Recent Changes

### 当前版本 (2024-12)
- ✅ **ELK Stack 8.13.4**: 完整的日志分析栈部署
  - Elasticsearch 单节点模式，内存限制512MB
  - Logstash 配置心跳监测和Apache日志格式解析
  - Kibana 集成Elasticsearch数据源
  
- ✅ **RocketMQ 5.1.0**: 分布式消息队列完整部署
  - NameServer 集群注册中心
  - Broker 异步主节点配置，自动创建主题
  - Dashboard Web管理界面

- ✅ **Nginx 配置**: 生产就绪的Web服务器配置
  - 安全头配置和XSS防护
  - 静态资源缓存优化
  - API代理预留接口

- 🔄 **MySQL 8**: 配置结构已准备，配置文件待完善

### 计划更新
- [ ] 完善MySQL 8配置文件
- [ ] 添加Redis缓存服务
- [ ] 集成应用监控服务 (Prometheus + Grafana)
- [ ] 添加服务编排脚本

## 📋 系统要求

- Docker Engine 20.10+
- Docker Compose 2.0+
- 可用内存至少 2GB (ELK Stack需要较多内存)

## 🤝 贡献

欢迎提交Issue和Pull Request来完善这个项目！
