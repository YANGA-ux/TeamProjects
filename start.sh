#!/bin/bash

echo "启动生物医药系统..."
echo

echo "1. 启动后端服务..."
cd backend
gnome-terminal --title="Backend Server" -- bash -c "mvn spring-boot:run; exec bash" &
cd ..

echo "2. 等待后端服务启动..."
sleep 10

echo "3. 启动前端服务..."
cd frontend
gnome-terminal --title="Frontend Server" -- bash -c "npm run dev; exec bash" &
cd ..

echo
echo "系统启动完成！"
echo "后端服务: http://localhost:8080"
echo "前端服务: http://localhost:5173"
echo 