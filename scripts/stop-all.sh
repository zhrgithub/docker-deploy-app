#!/bin/bash

echo "🛑 正在停止所有Docker服务..."

# 停止Nginx
echo "🌐 停止Nginx..."
docker stop nginx-server 2>/dev/null && docker rm nginx-server 2>/dev/null

# 停止监控系统
echo "📊 停止监控系统..."
cd ../monitoring && docker-compose down

# 停止日志系统
echo "📋 停止日志系统..."
cd ../logging/elk && docker-compose down

# 停止消息队列
echo "📨 停止消息队列服务..."
cd ../../messaging/rabbitmq && docker-compose down
cd ../rocket-mq && docker-compose down

# 停止配置中心
echo "⚙️  停止配置中心..."
cd ../../config-center/nacos/v3 && docker-compose down

# 停止基础设施服务
echo "📦 停止基础设施服务..."
cd ../../../infrastructure/mysql8 && docker-compose down

echo "✅ 所有服务已停止！"
