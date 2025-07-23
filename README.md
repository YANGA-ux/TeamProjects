# 生物医药系统 (Bio-Pharma System)

一个基于Spring Boot + Vue.js的生物医药管理系统，提供药品管理、新闻资讯、订单处理等功能。

## 功能特性

### 用户端功能
- 🏠 **用户主页** - 展示系统概览和热门内容
- 💊 **药品浏览** - 按分类浏览药品信息
- 🔍 **药品搜索** - 支持关键词搜索药品
- 📰 **新闻资讯** - 查看医药行业最新动态
- 🛒 **购物功能** - 添加药品到购物车并下单
- 👤 **个人中心** - 查看个人信息和订单历史

### 管理端功能
- 👥 **用户管理** - 管理系统用户
- 💊 **药品管理** - 添加、编辑、删除药品信息
- 📰 **新闻管理** - 发布和管理新闻资讯
- 📋 **订单管理** - 处理用户订单
- 📊 **数据统计** - 查看系统运营数据

## 技术栈

### 后端
- **Spring Boot 3.4.7** - 主框架
- **Spring Security** - 安全认证
- **MyBatis-Plus** - ORM框架
- **MySQL** - 数据库
- **Maven** - 依赖管理

### 前端
- **Vue 3** - 前端框架
- **Element Plus** - UI组件库
- **Vue Router** - 路由管理
- **Axios** - HTTP客户端
- **Vite** - 构建工具

## 快速开始

### 环境要求
- JDK 17+
- Node.js 16+
- MySQL 8.0+

### 1. 克隆项目
```bash
git clone <repository-url>
cd bio-pharma-system
```

### 2. 数据库配置
1. 创建MySQL数据库
```sql
CREATE DATABASE bio DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 执行初始化脚本
```bash
mysql -u root -p bio < backend/src/main/resources/sql/init.sql
```

3. 修改数据库配置
编辑 `backend/src/main/resources/application.yml`，更新数据库连接信息：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3307/bio?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
    username: your_username
    password: your_password
```

### 3. 启动后端服务
```bash
cd backend
mvn spring-boot:run
```
后端服务将在 http://localhost:8080 启动

### 4. 启动前端服务
```bash
cd frontend
npm install
npm run dev
```
前端服务将在 http://localhost:5173 启动

## 数据库结构

### 主要数据表
- `sys_user` - 用户表
- `drug` - 药品表
- `news` - 新闻表
- `orders` - 订单表

### 示例数据
系统已预置了示例药品和新闻数据，可以直接使用。

## API接口

### 用户认证
- `POST /api/login` - 用户登录
- `POST /api/register` - 用户注册
- `POST /api/change-password` - 修改密码

### 药品管理
- `GET /api/drugs` - 获取所有药品
- `GET /api/drugs/{id}` - 获取药品详情
- `GET /api/drugs/category/{category}` - 按分类获取药品
- `GET /api/drugs/search?keyword={keyword}` - 搜索药品
- `GET /api/drugs/hot` - 获取热门药品

### 新闻管理
- `GET /api/news` - 获取所有新闻
- `GET /api/news/latest?limit={limit}` - 获取最新新闻
- `GET /api/news/category/{category}` - 按分类获取新闻
- `GET /api/news/{id}` - 获取新闻详情

### 订单管理
- `GET /api/orders/user/{userId}` - 获取用户订单
- `POST /api/orders` - 创建订单
- `PUT /api/orders/{orderId}/status` - 更新订单状态
- `GET /api/orders/{orderId}` - 获取订单详情

## 部署说明

### 生产环境部署
1. 后端打包
```bash
cd backend
mvn clean package
```

2. 前端打包
```bash
cd frontend
npm run build
```

3. 部署到服务器
- 将后端jar包部署到服务器
- 将前端dist目录部署到Web服务器

## 开发说明

### 添加新功能
1. 在 `backend/src/main/java/com/hwadee/backend/entity` 中创建实体类
2. 在 `backend/src/main/java/com/hwadee/backend/mapper` 中创建Mapper接口
3. 在 `backend/src/main/java/com/hwadee/backend/service` 中创建Service接口和实现
4. 在 `backend/src/main/java/com/hwadee/backend/controller` 中创建Controller
5. 在前端 `frontend/src/views` 中创建对应的Vue组件

### 代码规范
- 遵循Java和Vue.js的编码规范
- 使用有意义的变量和方法名
- 添加必要的注释
- 保持代码简洁和可读性

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

如有问题或建议，请通过以下方式联系：
- 邮箱：your-email@example.com
- 项目地址：https://github.com/your-username/bio-pharma-system 