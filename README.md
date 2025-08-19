# Docker 部署应用集合

使用 Docker 快速部署各种常用应用和服务的配置集合。

## 📁 项目结构

项目已按功能域重新组织，结构更加清晰：

```
docker-deploy-app/
├── infrastructure/          # 基础设施服务
│   ├── mysql8/             # MySQL 8 数据库
│   └── nginx/              # Nginx Web服务器
├── logging/                # 日志相关
│   └── elk/                # ELK Stack (Elasticsearch + Logstash + Kibana)
├── messaging/              # 消息队列
│   ├── rabbitmq/           # RabbitMQ
│   └── rocket-mq/          # Apache RocketMQ
├── config-center/          # 配置中心
│   └── nacos/              # Nacos 配置中心和服务发现
├── monitoring/             # 监控系统
│   ├── prometheus/         # Prometheus 指标收集
│   └── grafana/            # Grafana 数据可视化
├── scripts/                # 管理脚本
│   ├── start-all.sh/ps1    # 一键启动所有服务
│   └── stop-all.sh/ps1     # 一键停止所有服务
├── env/                    # 环境配置
│   ├── env.template        # 环境变量模板
│   └── README.md           # 环境配置说明
└── README.md               # 项目说明文档
```

## 📋 当前部署服务列表

### 1. ELK Stack (Elasticsearch + Logstash + Kibana)
- **版本**: 8.13.4
- **服务组件**:
  - **Elasticsearch**: 端口 9200，单节点模式，禁用安全认证
  - **Logstash**: 端口 5044, 9600，配置心跳监测和日志处理
  - **Kibana**: 端口 5601，数据可视化界面
- **用途**: 日志收集、分析和可视化
- **启动命令**: `cd logging/elk && docker-compose up -d`

### 2. RocketMQ 消息队列
- **版本**: Apache RocketMQ 5.1.0
- **服务组件**:
  - **NameServer**: 端口 9876，注册中心
  - **Broker**: 端口 10911, 10909，消息代理，异步主节点配置
  - **Dashboard**: 端口 8082，Web管理界面
- **用途**: 分布式消息队列服务
- **启动命令**: `cd messaging/rocket-mq && docker-compose up -d`

### 3. Nginx Web服务器
- **配置**: 自定义配置文件
- **服务功能**:
  - 静态文件服务（端口 80）
  - 打印演示站点配置
  - 安全头配置（X-Frame-Options, X-XSS-Protection等）
  - 静态资源缓存优化
  - API代理预留配置
- **用途**: Web服务器和反向代理
- **启动命令**: `docker run -d -p 80:80 -v $(pwd)/infrastructure/nginx/conf/nginx.conf:/etc/nginx/nginx.conf nginx`

### 4. RabbitMQ 消息队列
- **版本**: RabbitMQ 3.10-management
- **服务组件**:
  - **RabbitMQ Server**: 端口 5672，消息代理服务
  - **Management UI**: 端口 15672，Web管理界面
- **配置特性**:
  - 内置管理控制台，用户名/密码：admin/admin
  - 支持健康检查和自动重启
  - 时区设置为Asia/Shanghai
- **用途**: 轻量级消息队列服务
- **启动命令**: `cd messaging/rabbitmq && docker-compose up -d`
- **访问地址**: http://localhost:15672

### 5. MySQL 8 数据库
- **配置**: 预留配置目录结构
- **状态**: 配置文件待完善
- **用途**: 关系型数据库服务

### 6. Nacos 配置中心
- **版本**: nacos/nacos-server:latest
- **服务组件**:
  - **Nacos Server**: 端口 8848，配置管理和服务发现
  - **集群通信**: 端口 9848, 9849
- **配置特性**:
  - 单机模式部署，使用内嵌存储
  - 开启安全认证（用户名/密码：nacos/nacos）
  - JVM内存配置：512MB
  - 数据持久化
- **用途**: 微服务配置管理和服务注册发现
- **启动命令**: `cd config-center/nacos/v3 && docker-compose up -d`
- **访问地址**: http://localhost:8848/nacos

### 7. 监控系统 (Prometheus + Grafana)
- **服务组件**:
  - **Prometheus**: 端口 9091，指标收集和存储
  - **Grafana**: 端口 3000，数据可视化（admin/admin）
  - **MySQL Exporter**: 端口 9104，MySQL指标导出
- **配置特性**:
  - Grafana预配置MySQL仪表板
  - Prometheus自定义配置
  - MySQL监控集成
- **用途**: 应用性能监控和数据可视化
- **启动命令**: `cd monitoring && docker-compose up -d`

## 🚀 快速开始

### 方式一：一键启动所有服务 (推荐)

1. 克隆项目：
```bash
git clone <repository-url>
cd docker-deploy-app
```

2. Linux/macOS系统：
```bash
chmod +x scripts/start-all.sh
./scripts/start-all.sh
```

3. Windows系统：
```powershell
.\scripts\start-all.ps1
```

### 方式二：按需启动单个服务

```bash
# 启动ELK Stack
cd logging/elk && docker-compose up -d

# 启动RocketMQ
cd messaging/rocket-mq && docker-compose up -d

# 启动RabbitMQ
cd messaging/rabbitmq && docker-compose up -d

# 启动Nacos配置中心
cd config-center/nacos/v3 && docker-compose up -d

# 启动监控系统
cd monitoring && docker-compose up -d

# 启动MySQL8
cd infrastructure/mysql8 && docker-compose up -d
```

3. 访问服务：
   - Kibana: http://localhost:5601
   - RocketMQ Dashboard: http://localhost:8082
   - Nacos: http://localhost:8848/nacos (nacos/nacos)
   - Grafana: http://localhost:3000 (admin/admin)
   - Prometheus: http://localhost:9091
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

- ✅ **Nacos 配置中心**: 微服务配置管理和服务发现
  - 单机模式部署，使用内嵌存储
  - 安全认证和数据持久化
  - Web管理界面

- ✅ **监控系统**: Prometheus + Grafana 监控栈
  - Prometheus指标收集和存储
  - Grafana数据可视化和仪表板
  - MySQL Exporter数据库监控

- 🔄 **MySQL 8**: 配置结构已准备，配置文件待完善

## 🎯 新特性

### 功能域分类管理
- **基础设施服务**: MySQL、Nginx等基础组件
- **日志系统**: ELK Stack完整日志解决方案
- **消息队列**: RabbitMQ、RocketMQ多种选择
- **配置中心**: Nacos服务注册和配置管理
- **监控系统**: Prometheus + Grafana监控栈

### 统一管理脚本
- **一键启动**: 支持Linux/macOS和Windows
- **一键停止**: 优雅停止所有服务
- **环境配置**: 统一的环境变量管理

### 计划更新
- [ ] 完善MySQL 8配置文件
- [ ] 添加Redis缓存服务  
- [ ] 添加服务健康检查脚本
- [ ] 集成服务网格 (Istio)
- [ ] 添加日志聚合到监控系统
- [ ] 添加备份和恢复脚本

## 📋 系统要求

- Docker Engine 20.10+
- Docker Compose 2.0+
- 可用内存至少 4GB (ELK Stack + 监控系统需要较多内存)
- 可用磁盘空间至少 10GB (用于数据持久化)

## 🤝 贡献

欢迎提交Issue和Pull Request来完善这个项目！
