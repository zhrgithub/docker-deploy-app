# Windows PowerShell版本的启动脚本

Write-Host "🚀 正在启动所有Docker服务..." -ForegroundColor Green

# 启动基础设施服务
Write-Host "📦 启动基础设施服务..." -ForegroundColor Yellow
Set-Location infrastructure/mysql8
docker-compose up -d
Start-Sleep 5

# 启动配置中心
Write-Host "⚙️  启动配置中心..." -ForegroundColor Yellow
Set-Location ../../config-center/nacos/v3
docker-compose up -d
Start-Sleep 10

# 启动消息队列
Write-Host "📨 启动消息队列服务..." -ForegroundColor Yellow
Set-Location ../../../messaging/rabbitmq
docker-compose up -d
Set-Location ../rocket-mq
docker-compose up -d
Start-Sleep 10

# 启动日志系统
Write-Host "📋 启动日志系统..." -ForegroundColor Yellow
Set-Location ../../logging/elk
docker-compose up -d
Start-Sleep 15

# 启动监控系统
Write-Host "📊 启动监控系统..." -ForegroundColor Yellow
Set-Location ../../monitoring
docker-compose up -d
Start-Sleep 10

# 启动Nginx
Write-Host "🌐 启动Nginx..." -ForegroundColor Yellow
Set-Location ../infrastructure/nginx
$nginxConfPath = (Get-Location).Path + "\conf\nginx.conf"
docker run -d -p 80:80 --name nginx-server -v "${nginxConfPath}:/etc/nginx/nginx.conf" nginx

Write-Host "✅ 所有服务启动完成！" -ForegroundColor Green
Write-Host ""
Write-Host "🔗 访问地址：" -ForegroundColor Cyan
Write-Host "   - Kibana (日志):      http://localhost:5601"
Write-Host "   - RocketMQ Dashboard: http://localhost:8082"
Write-Host "   - Nacos (配置中心):   http://localhost:8848/nacos (nacos/nacos)"
Write-Host "   - Grafana (监控):     http://localhost:3000 (admin/admin)"
Write-Host "   - Prometheus:         http://localhost:9091"
Write-Host "   - RabbitMQ:           http://localhost:15672 (admin/admin)"
Write-Host "   - Nginx:              http://localhost"
