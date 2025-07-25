# 问题解决指南

## 🚨 常见问题及解决方案

### 1. 图标导入错误
**错误信息**: `The requested module does not provide an export named 'MedicineBox'`

**原因**: Element Plus 图标库中没有 `MedicineBox` 图标

**解决方案**: 
- 已修复：将 `MedicineBox` 替换为 `Box` 图标
- 访问简单测试页面：http://localhost:5173/simple

### 2. 页面显示空白
**可能原因**:
- JavaScript 错误阻止了页面渲染
- API 连接失败
- 数据库连接问题

**解决步骤**:
1. 打开浏览器开发者工具 (F12)
2. 查看 Console 标签页的错误信息
3. 访问简单测试页面：http://localhost:5173/simple
4. 点击"测试基础功能"按钮

### 3. 网络请求显示 304
**说明**: 304 状态码是正常的，表示资源从缓存加载

**如果遇到问题**:
1. 在开发者工具中勾选"禁用缓存"
2. 刷新页面
3. 检查 Network 标签页中的 API 请求状态

### 4. 数据库连接失败
**检查步骤**:
1. 确认 MySQL 服务已启动
2. 检查数据库配置：
   ```yaml
   spring:
     datasource:
       url: jdbc:mysql://localhost:3307/bio?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
       username: root
       password: 123456
   ```
3. 确认数据库和表已创建：
   ```sql
   USE bio;
   SHOW TABLES;
   ```

### 5. 后端服务启动失败
**常见原因**:
- 端口被占用
- 数据库连接失败
- 依赖缺失

**解决步骤**:
1. 检查控制台错误信息
2. 确认 8080 端口未被占用
3. 检查数据库连接
4. 重新安装依赖：`mvn clean install`

### 6. 前端服务启动失败
**常见原因**:
- 端口被占用
- 依赖缺失
- Node.js 版本不兼容

**解决步骤**:
1. 检查控制台错误信息
2. 确认 5173 端口未被占用
3. 重新安装依赖：`npm install`
4. 清除缓存：`npm run dev -- --force`

## 🔧 测试步骤

### 1. 基础功能测试
访问：http://localhost:5173/simple
- 点击"测试基础功能"
- 应该显示成功消息

### 2. API 连接测试
- 点击"测试API连接"
- 应该返回后端服务信息

### 3. 数据获取测试
- 点击"获取测试数据"
- 应该显示药品和新闻数据

### 4. 完整功能测试
访问：http://localhost:5173/test
- 测试所有API接口
- 检查数据库连接

## 📞 获取帮助

如果问题仍然存在：

1. **查看日志**：
   - 后端：查看控制台输出
   - 前端：查看浏览器控制台

2. **检查网络**：
   - 确认后端服务在 http://localhost:8080
   - 确认前端服务在 http://localhost:5173

3. **验证数据**：
   - 检查数据库中是否有数据
   - 确认表结构正确

4. **重启服务**：
   - 停止所有服务
   - 重新启动后端和前端

## 🎯 快速诊断

运行以下命令进行快速诊断：

```bash
# 检查后端服务
curl http://localhost:8080/api/test/simple

# 检查数据库
curl http://localhost:8080/api/test/database

# 检查前端服务
curl http://localhost:5173
```

如果以上命令都返回正常响应，说明系统运行正常。 