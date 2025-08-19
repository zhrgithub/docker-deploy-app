# Windows PowerShell版本的停止脚本

Write-Host "🛑 正在停止所有Docker服务..." -ForegroundColor Red

# 停止Nginx
Write-Host "🌐 停止Nginx..." -ForegroundColor Yellow
docker stop nginx-server 2>$null
docker rm nginx-server 2>$null

# 停止监控系统
Write-Host "📊 停止监控系统..." -ForegroundColor Yellow
Set-Location ../monitoring
docker-compose down

# 停止日志系统
Write-Host "📋 停止日志系统..." -ForegroundColor Yellow
Set-Location ../logging/elk
docker-compose down

# 停止消息队列
Write-Host "📨 停止消息队列服务..." -ForegroundColor Yellow
Set-Location ../../messaging/rabbitmq
docker-compose down
Set-Location ../rocket-mq
docker-compose down

# 停止配置中心
Write-Host "⚙️  停止配置中心..." -ForegroundColor Yellow
Set-Location ../../config-center/nacos/v3
docker-compose down

# 停止基础设施服务
Write-Host "📦 停止基础设施服务..." -ForegroundColor Yellow
Set-Location ../../../infrastructure/mysql8
docker-compose down

Write-Host "✅ 所有服务已停止！" -ForegroundColor Green
