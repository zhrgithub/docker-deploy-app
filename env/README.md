# 环境配置说明

## 📋 环境变量配置

### 快速开始

1. 复制环境变量模板：
```bash
cp env.template .env
```

2. 根据你的环境修改 `.env` 文件中的配置项

3. 在docker-compose文件中引用环境变量：
```yaml
env_file:
  - ../../env/.env
```

### 🔧 配置项说明

#### 通用配置
- `TZ`: 时区设置，默认为Asia/Shanghai
- `PROJECT_ROOT`: 项目根目录，用于Docker数据卷挂载

#### 数据库配置
- `MYSQL_ROOT_PASSWORD`: MySQL root用户密码
- `MYSQL_DATABASE`: 默认数据库名
- `MYSQL_USER/MYSQL_PASSWORD`: 应用数据库用户凭据

#### 消息队列配置
- `RABBITMQ_DEFAULT_USER/PASS`: RabbitMQ管理员凭据
- `ROCKETMQ_*`: RocketMQ相关端口配置

#### 监控配置
- `PROMETHEUS_PORT`: Prometheus服务端口
- `GRAFANA_ADMIN_*`: Grafana管理员凭据

### 🚀 使用示例

在docker-compose.yml中使用环境变量：

```yaml
services:
  mysql:
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
    ports:
      - "${MYSQL_PORT}:3306"
```

### 📝 注意事项

1. `.env` 文件包含敏感信息，不要提交到版本控制系统
2. 生产环境中请使用强密码
3. 确保端口不与其他服务冲突
