#!/bin/bash

echo "🚀 正在启动所有Docker服务..."

# 启动基础设施服务
echo "📦 启动基础设施服务..."
cd infrastructure/mysql8 && docker-compose up -d
sleep 5

# 启动配置中心
echo "⚙️  启动配置中心..."
cd ../../config-center/nacos/v3 && docker-compose up -d
sleep 10

# 启动消息队列
echo "📨 启动消息队列服务..."
cd ../../../messaging/rabbitmq && docker-compose up -d
cd ../rocket-mq && docker-compose up -d
sleep 10

# 启动日志系统
echo "📋 启动日志系统..."
cd ../../logging/elk && docker-compose up -d
sleep 15

# 启动监控系统
echo "📊 启动监控系统..."
cd ../../monitoring && docker-compose up -d
sleep 10

# 启动Nginx
echo "🌐 启动Nginx..."
cd ../infrastructure/nginx && docker run -d -p 80:80 --name nginx-server -v $(pwd)/conf/nginx.conf:/etc/nginx/nginx.conf nginx

echo "✅ 所有服务启动完成！"
echo ""
echo "🔗 访问地址："
echo "   - Kibana (日志):      http://localhost:5601"
echo "   - RocketMQ Dashboard: http://localhost:8082"
echo "   - Nacos (配置中心):   http://localhost:8848/nacos (nacos/nacos)"
echo "   - Grafana (监控):     http://localhost:3000 (admin/admin)"
echo "   - Prometheus:         http://localhost:9091"
echo "   - RabbitMQ:           http://localhost:15672 (admin/admin)"
echo "   - Nginx:              http://localhost"
