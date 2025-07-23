# 快速启动指南

## 🚀 一键启动

### Windows用户
双击运行 `start.bat` 文件

### Linux/Mac用户
```bash
chmod +x start.sh
./start.sh
```

## 📋 手动启动步骤

### 1. 数据库准备
```sql
-- 创建数据库
CREATE DATABASE bio DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 执行初始化脚本
mysql -u root -p bio < backend/src/main/resources/sql/init.sql
```

### 2. 启动后端
```bash
cd backend
mvn spring-boot:run
```

### 3. 启动前端
```bash
cd frontend
npm install
npm run dev
```

## 🔧 系统测试

启动完成后，访问测试页面验证系统：
- 测试页面：http://localhost:5173/test
- 用户主页：http://localhost:5173/user
- 登录页面：http://localhost:5173/login

## 📊 默认数据

系统已预置以下示例数据：

### 药品数据
- 阿莫西林胶囊 (抗生素)
- 布洛芬片 (解热镇痛)
- 感冒灵颗粒 (感冒用药)
- 维生素C片 (维生素)
- 板蓝根颗粒 (清热解毒)
- 藿香正气水 (祛暑药)
- 创可贴 (外用药品)
- 红霉素软膏 (外用药品)

### 新闻数据
- 新型疫苗研发取得重大突破
- 国家药监局发布新政策
- 中医药现代化发展报告
- 罕见病药物研发进展
- 医疗器械创新技术展示

## 🐛 常见问题

### 1. 编译错误：找不到setStatus方法
**解决方案**：已修复，所有实体类现在都有完整的getter/setter方法

### 2. 数据库连接失败
**检查项**：
- MySQL服务是否启动
- 数据库连接配置是否正确
- 数据库和表是否已创建

### 3. 前端无法访问后端API
**检查项**：
- 后端服务是否在8080端口启动
- CORS配置是否正确
- 网络连接是否正常

### 4. 端口被占用
**解决方案**：
- 修改 `application.yml` 中的端口配置
- 或关闭占用端口的程序

## 📞 技术支持

如遇问题，请：
1. 查看控制台错误信息
2. 访问测试页面进行诊断
3. 检查README.md获取详细文档 