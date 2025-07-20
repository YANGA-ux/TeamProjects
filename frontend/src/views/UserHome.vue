<template>
  <div class="user-home">
    <!-- 顶部导航栏 -->
    <el-header class="header">
      <div class="header-content">
        <div class="logo">
          <h2>生物医药企业管理系统</h2>
        </div>
        <div class="user-info">
          <el-dropdown>
            <span class="user-dropdown">
              <el-avatar :size="32" icon="UserFilled" />
              <span style="margin-left: 8px">{{ userInfo.real_name || userInfo.username }}</span>
              <span style="margin-left: 8px; color: #666;">({{ userInfo.role }})</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="showProfile">个人信息</el-dropdown-item>
                <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </el-header>

    <!-- 主要内容区域 -->
    <el-main class="main-content">
      <!-- 欢迎横幅 -->
      <el-card class="welcome-banner">
        <h2>欢迎使用生物医药企业管理系统</h2>
        <p>当前用户：{{ userInfo.real_name || userInfo.username }} | 角色：{{ userInfo.role }}</p>
      </el-card>

      <!-- 功能模块 -->
      <div class="modules-section">
        <h3>功能模块</h3>
        <p>调试信息 - 当前用户角色: {{ userInfo.role }}</p>
        <p>调试信息 - 研发管理权限: {{ hasPermission('rd') }}</p>
        <el-row :gutter="20">
          <!-- 研发模块 -->
          <el-col :span="8" v-if="hasPermission('rd')">
            <el-card class="module-card" @click="goToModule('rd')">
              <div class="module-icon rd">
                <el-icon :size="40"><Search /></el-icon>
              </div>
              <h4>研发管理</h4>
              <p>化合物研发、实验记录、文献管理</p>
              <div class="module-stats">
                <span>化合物：{{ stats.compounds || 0 }}</span>
                <span>实验：{{ stats.experiments || 0 }}</span>
              </div>
            </el-card>
          </el-col>

          <!-- 生产模块 -->
          <el-col :span="8" v-if="hasPermission('prod')">
            <el-card class="module-card" @click="goToModule('prod')">
              <div class="module-icon prod">
                <el-icon :size="40"><Box /></el-icon>
              </div>
              <h4>生产管理</h4>
              <p>批次管理、质量控制、生产监控</p>
              <div class="module-stats">
                <span>批次：{{ stats.batches || 0 }}</span>
                <span>标准：{{ stats.standards || 0 }}</span>
              </div>
            </el-card>
          </el-col>

          <!-- 供应链模块 -->
          <el-col :span="8" v-if="hasPermission('scm')">
            <el-card class="module-card" @click="goToModule('scm')">
              <div class="module-icon scm">
                <el-icon :size="40"><CircleCheck /></el-icon>
              </div>
              <h4>供应链管理</h4>
              <p>物料管理、供应商管理、采购管理</p>
              <div class="module-stats">
                <span>物料：{{ stats.materials || 0 }}</span>
                <span>供应商：{{ stats.suppliers || 0 }}</span>
              </div>
            </el-card>
          </el-col>

          <!-- 系统管理模块 -->
          <el-col :span="8" v-if="hasPermission('sys')">
            <el-card class="module-card" @click="goToModule('sys')">
              <div class="module-icon sys">
                <el-icon :size="40"><UserFilled /></el-icon>
              </div>
              <h4>系统管理</h4>
              <p>用户管理、权限管理、系统监控</p>
              <div class="module-stats">
                <span>用户：{{ stats.users || 0 }}</span>
                <span>角色：{{ stats.roles || 0 }}</span>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>

      <!-- 快捷操作 -->
      <div class="quick-actions">
        <h3>快捷操作</h3>
        <el-row :gutter="20">
          <el-col :span="6" v-if="hasPermission('rd')">
            <el-button type="primary" class="quick-action-btn" @click="quickAction('addCompound')">
              <el-icon><Plus /></el-icon>
              新增化合物
            </el-button>
          </el-col>
          <el-col :span="6" v-if="hasPermission('rd')">
            <el-button type="success" class="quick-action-btn" @click="quickAction('newExperiment')">
              <el-icon><Document /></el-icon>
              创建实验
            </el-button>
          </el-col>
          <el-col :span="6" v-if="hasPermission('prod')">
            <el-button type="warning" class="quick-action-btn" @click="quickAction('newBatch')">
              <el-icon><Box /></el-icon>
              新建批次
            </el-button>
          </el-col>
          <el-col :span="6" v-if="hasPermission('scm')">
            <el-button type="info" class="quick-action-btn" @click="quickAction('addSupplier')">
              <el-icon><UserFilled /></el-icon>
              添加供应商
            </el-button>
          </el-col>
        </el-row>
      </div>

      <!-- 待办事项 -->
      <div class="todo-section">
        <h3>待办事项</h3>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-card>
              <template #header>
                <div class="card-header">
                  <span>我的待办</span>
                  <el-button link @click="refreshTodos">刷新</el-button>
                </div>
              </template>
              <div v-if="todos.length > 0">
                <div v-for="todo in todos" :key="todo.id" class="todo-item">
                  <el-checkbox v-model="todo.completed" @change="updateTodo(todo)">
                    {{ todo.title }}
                  </el-checkbox>
                  <span class="todo-time">{{ formatDate(todo.dueDate) }}</span>
                </div>
              </div>
              <div v-else class="no-todo">
                暂无待办事项
              </div>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card>
              <template #header>
                <div class="card-header">
                  <span>系统通知</span>
                  <el-button link @click="markAllRead">全部已读</el-button>
                </div>
              </template>
              <div v-if="notifications.length > 0">
                <div v-for="notification in notifications" :key="notification.id" class="notification-item">
                  <div class="notification-icon">
                    <el-icon :size="16" :color="notification.type === 'warning' ? '#E6A23C' : '#409EFF'">
                      <Warning v-if="notification.type === 'warning'" />
                      <InfoFilled v-else />
                    </el-icon>
                  </div>
                  <div class="notification-content">
                    <div class="notification-title">{{ notification.title }}</div>
                    <div class="notification-time">{{ formatDate(notification.time) }}</div>
                  </div>
                </div>
              </div>
              <div v-else class="no-notification">
                暂无系统通知
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>

      <!-- 最近活动 -->
      <div class="recent-activity">
        <h3>最近活动</h3>
        <el-card>
          <div v-if="recentActivities.length > 0">
            <div v-for="activity in recentActivities" :key="activity.id" class="activity-item">
              <div class="activity-icon">
                <el-icon :size="20" :color="activity.color">
                  <component :is="activity.icon" />
                </el-icon>
              </div>
              <div class="activity-content">
                <div class="activity-title">{{ activity.title }}</div>
                <div class="activity-time">{{ formatDate(activity.time) }}</div>
              </div>
            </div>
          </div>
          <div v-else class="no-activity">
            暂无最近活动
          </div>
        </el-card>
      </div>

      <!-- 系统统计 -->
      <div class="system-stats">
        <h3>系统统计</h3>
        <el-row :gutter="20">
          <el-col :span="6">
            <el-card class="stat-card">
              <div class="stat-number">{{ stats.totalUsers || 0 }}</div>
              <div class="stat-label">总用户数</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card class="stat-card">
              <div class="stat-number">{{ stats.totalCompounds || 0 }}</div>
              <div class="stat-label">化合物总数</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card class="stat-card">
              <div class="stat-number">{{ stats.totalBatches || 0 }}</div>
              <div class="stat-label">生产批次</div>
            </el-card>
          </el-col>
          <el-col :span="6">
            <el-card class="stat-card">
              <div class="stat-number">{{ stats.totalSuppliers || 0 }}</div>
              <div class="stat-label">供应商数</div>
            </el-card>
          </el-col>
        </el-row>
      </div>
    </el-main>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Search, UserFilled, Box, CircleCheck, Plus, Document, Warning, InfoFilled } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()

const userInfo = ref({})
const recentActivities = ref([])
const todos = ref([])
const notifications = ref([])
const stats = reactive({
  compounds: 0,
  experiments: 0,
  batches: 0,
  standards: 0,
  materials: 0,
  suppliers: 0,
  users: 0,
  roles: 0,
  totalUsers: 0,
  totalCompounds: 0,
  totalBatches: 0,
  totalSuppliers: 0
})

// 权限检查
const hasPermission = (module) => {
  const role = userInfo.value.role
  console.log(`检查权限 - 模块: ${module}, 角色: ${role}`) // 添加调试日志
  
  // 处理角色大小写问题
  const normalizedRole = role ? role.toLowerCase() : ''
  console.log(`标准化后的角色: ${normalizedRole}`) // 添加调试日志
  
  if (normalizedRole === 'admin') {
    console.log('管理员权限，允许访问') // 添加调试日志
    return true
  }

  const permissions = {
    'rd': ['researcher', 'admin', '普通用户', 'user'], // 允许普通用户访问研发管理
    'prod': ['producer', 'admin'],
    'scm': ['supplier', 'admin'],
    'sys': ['admin']
  }

  const hasAccess = permissions[module]?.includes(normalizedRole) || false
  console.log(`权限检查结果: ${hasAccess}`) // 添加调试日志
  return hasAccess
}

// 跳转到模块
const goToModule = (module) => {
  console.log('点击模块:', module) // 添加调试日志
  console.log('当前用户角色:', userInfo.value.role) // 添加调试日志
  
  const moduleRoutes = {
    'rd': '/rd/compounds', // 研发管理跳转到化合物管理
    // 'prod': '/prod/batches', // 生产管理跳转到批次管理
    // 'scm': '/scm/materials', // 供应链管理跳转到物料管理
    // 'sys': '/sys/users' // 系统管理跳转到用户管理
  }
  
  const route = moduleRoutes[module]
  console.log('目标路由:', route) // 添加调试日志
  
  if (route) {
    console.log('正在跳转到:', route) // 添加调试日志
    router.push(route)
    ElMessage.success(`正在跳转到${module}模块...`)
  } else {
    console.log('模块功能开发中:', module) // 添加调试日志
    ElMessage.info(`${module} 模块功能开发中...`)
  }
}

// 快捷操作
const quickAction = (action) => {
  const actionRoutes = {
    addCompound: '/rd/compounds', // 新增化合物跳转到化合物管理页面
    newExperiment: '/rd/compounds', // 创建实验暂时跳转到化合物管理
    newBatch: '/rd/compounds', // 新建批次暂时跳转到化合物管理
    addSupplier: '/rd/compounds' // 添加供应商暂时跳转到化合物管理
  }
  
  const route = actionRoutes[action]
  if (route) {
    router.push(route)
    ElMessage.success('正在跳转到相关页面...')
  } else {
    ElMessage.info(`${action}功能开发中...`)
  }
}

// 刷新待办事项
const refreshTodos = async () => {
  await getTodos()
  ElMessage.success('待办事项已刷新')
}

// 更新待办事项
const updateTodo = (todo) => {
  ElMessage.success(`待办事项"${todo.title}"已${todo.completed ? '完成' : '取消完成'}`)
}

// 标记所有通知为已读
const markAllRead = () => {
  notifications.value = []
  ElMessage.success('所有通知已标记为已读')
}

// 显示个人信息
const showProfile = () => {
  ElMessage.info('个人信息功能开发中...')
}

// 退出登录
const logout = () => {
  ElMessage.success('退出登录成功')
  router.push('/login')
}

// 格式化日期
const formatDate = (str) => {
  if (!str) return ''
  return new Date(str).toLocaleString('zh-CN')
}

// 获取用户信息
const getUserInfo = async () => {
  try {
    // 从localStorage获取当前登录用户
    const currentUser = localStorage.getItem('currentUser')
    console.log('localStorage中的用户信息:', currentUser) // 添加调试日志
    
    if (currentUser) {
      const user = JSON.parse(currentUser)
      console.log('解析的用户信息:', user) // 添加调试日志
      
      const res = await axios.get(`http://localhost:8080/api/user/info?username=${user.username}`)
      console.log('用户信息API响应:', res.data) // 添加调试日志
      
      if (res.data.code === 200) {
        userInfo.value = res.data.data
        console.log('设置的用户信息:', userInfo.value) // 添加调试日志
      } else {
        console.log('用户信息API返回错误:', res.data) // 添加调试日志
        // 如果获取失败，使用本地存储的数据
        userInfo.value = {
          username: user.username,
          real_name: user.real_name || user.username,
          role: user.role || '普通用户'
        }
      }
    } else {
      console.log('localStorage中没有用户信息，使用默认数据') // 添加调试日志
      // 默认用户信息
      userInfo.value = {
        username: 'admin',
        real_name: '系统管理员',
        role: '系统管理员'
      }
    }
  } catch (error) {
    console.error('获取用户信息失败:', error)
    // 使用默认数据
    userInfo.value = {
      username: 'admin',
      real_name: '系统管理员',
      role: '系统管理员'
    }
  }
}

// 获取统计数据
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/stats/dashboard')
    console.log('统计数据响应:', res.data) // 添加调试日志
    
    if (res.data.code === 200) {
      const data = res.data.data
      console.log('解析的数据:', data) // 添加调试日志
      
      Object.assign(stats, {
        compounds: data.rd?.compounds || 0,
        experiments: data.rd?.experiments || 0,
        batches: data.prod?.batches || 0,
        standards: data.prod?.standards || 0,
        materials: data.scm?.materials || 0,
        suppliers: data.scm?.suppliers || 0,
        users: data.sys?.users || 0,
        roles: data.sys?.roles || 0,
        totalUsers: data.totalUsers || 0,
        totalCompounds: data.totalCompounds || 0,
        totalBatches: data.totalBatches || 0,
        totalSuppliers: data.totalSuppliers || 0
      })
      
      console.log('更新后的stats:', stats) // 添加调试日志
    } else {
      console.log('API返回错误:', res.data) // 添加调试日志
      // 如果获取失败，使用默认数据
      Object.assign(stats, {
        compounds: 156,
        experiments: 89,
        batches: 45,
        standards: 23,
        materials: 234,
        suppliers: 67,
        users: 89,
        roles: 5,
        totalUsers: 89,
        totalCompounds: 156,
        totalBatches: 45,
        totalSuppliers: 67
      })
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
    // 使用默认数据
    Object.assign(stats, {
      compounds: 156,
      experiments: 89,
      batches: 45,
      standards: 23,
      materials: 234,
      suppliers: 67,
      users: 89,
      roles: 5,
      totalUsers: 89,
      totalCompounds: 156,
      totalBatches: 45,
      totalSuppliers: 67
    })
  }
}

// 获取最近活动
const getRecentActivities = async () => {
  try {
    // 这里应该从后端获取最近活动
    // const res = await axios.get('http://localhost:8080/api/activities')
    // recentActivities.value = res.data.data

    // 模拟数据
    recentActivities.value = [
      {
        id: 1,
        title: '新增化合物记录',
        time: '2024-01-15T10:30:00',
        icon: 'Search',
        color: '#409EFF'
      },
      {
        id: 2,
        title: '完成实验批次',
        time: '2024-01-15T09:15:00',
        icon: 'Box',
        color: '#67C23A'
      },
      {
        id: 3,
        title: '更新质量标准',
        time: '2024-01-15T08:45:00',
        icon: 'CircleCheck',
        color: '#E6A23C'
      }
    ]
  } catch (error) {
    console.error('获取最近活动失败:', error)
  }
}

// 获取待办事项
const getTodos = async () => {
  try {
    // 这里应该从后端获取待办事项
    // const res = await axios.get('http://localhost:8080/api/todos')
    // todos.value = res.data.data

    // 模拟数据
    todos.value = [
      {
        id: 1,
        title: '完成化合物A的毒性测试',
        completed: false,
        dueDate: '2024-01-20T18:00:00'
      },
      {
        id: 2,
        title: '审核实验报告',
        completed: true,
        dueDate: '2024-01-18T18:00:00'
      },
      {
        id: 3,
        title: '更新文献资料',
        completed: false,
        dueDate: '2024-01-25T18:00:00'
      }
    ]
  } catch (error) {
    console.error('获取待办事项失败:', error)
  }
}

// 获取系统通知
const getNotifications = async () => {
  try {
    // 这里应该从后端获取系统通知
    // const res = await axios.get('http://localhost:8080/api/notifications')
    // notifications.value = res.data.data

    // 模拟数据
    notifications.value = [
      {
        id: 1,
        title: '系统维护通知：今晚22:00-24:00进行系统升级',
        type: 'warning',
        time: '2024-01-15T14:30:00'
      },
      {
        id: 2,
        title: '新用户注册：李四已加入研发团队',
        type: 'info',
        time: '2024-01-15T13:15:00'
      },
      {
        id: 3,
        title: '数据备份完成：所有数据已安全备份',
        type: 'info',
        time: '2024-01-15T12:00:00'
      }
    ]
  } catch (error) {
    console.error('获取系统通知失败:', error)
  }
}

onMounted(async () => {
  await getUserInfo()
  await getStats()
  await getRecentActivities()
  await getTodos()
  await getNotifications()
  
  // 添加调试信息
  console.log('页面加载完成，用户信息:', userInfo.value)
  console.log('研发管理权限:', hasPermission('rd'))
  console.log('生产管理权限:', hasPermission('prod'))
  console.log('供应链管理权限:', hasPermission('scm'))
  console.log('系统管理权限:', hasPermission('sys'))
})
</script>

<style scoped>
.user-home {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.header {
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  height: 100%;
}

.logo h2 {
  color: #409EFF;
  margin: 0;
}

.user-dropdown {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.main-content {
  margin-top: 60px;
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
  padding: 20px;
}

.welcome-banner {
  margin-bottom: 30px;
  text-align: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.welcome-banner h2 {
  margin: 0 0 10px 0;
  font-size: 2em;
}

.welcome-banner p {
  margin: 0;
  font-size: 1.1em;
  opacity: 0.9;
}

.modules-section,
.quick-actions,
.todo-section,
.recent-activity,
.system-stats {
  margin-bottom: 40px;
}

.modules-section h3,
.quick-actions h3,
.todo-section h3,
.recent-activity h3,
.system-stats h3 {
  color: #333;
  margin-bottom: 20px;
  font-size: 1.5em;
}

.module-card {
  cursor: pointer;
  transition: transform 0.3s;
  text-align: center;
  height: 200px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.module-card:hover {
  transform: translateY(-5px);
}

.module-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 15px;
  color: white;
}

.module-icon.rd {
  background: linear-gradient(135deg, #409EFF, #36a3f7);
}

.module-icon.prod {
  background: linear-gradient(135deg, #67C23A, #85ce61);
}

.module-icon.scm {
  background: linear-gradient(135deg, #E6A23C, #ebb563);
}

.module-icon.sys {
  background: linear-gradient(135deg, #F56C6C, #f78989);
}

.module-card h4 {
  margin: 0 0 10px 0;
  color: #333;
}

.module-card p {
  color: #666;
  margin: 0 0 15px 0;
  font-size: 0.9em;
}

.module-stats {
  display: flex;
  justify-content: space-around;
  font-size: 0.8em;
  color: #999;
}

.activity-item {
  display: flex;
  align-items: center;
  padding: 15px 0;
  border-bottom: 1px solid #eee;
}

.activity-item:last-child {
  border-bottom: none;
}

.activity-icon {
  margin-right: 15px;
}

.activity-content {
  flex: 1;
}

.activity-title {
  font-weight: 500;
  color: #333;
  margin-bottom: 5px;
}

.activity-time {
  font-size: 0.8em;
  color: #999;
}

.no-activity {
  text-align: center;
  color: #999;
  padding: 40px 0;
}

.stat-card {
  text-align: center;
  padding: 20px;
}

.stat-number {
  font-size: 2em;
  font-weight: bold;
  color: #409EFF;
  margin-bottom: 10px;
}

.stat-label {
  color: #666;
  font-size: 0.9em;
}

.quick-action-btn {
  width: 100%;
  height: 60px;
  font-size: 1.1em;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.todo-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.todo-item:last-child {
  border-bottom: none;
}

.todo-time {
  font-size: 0.8em;
  color: #999;
}

.no-todo,
.no-notification {
  text-align: center;
  color: #999;
  padding: 20px 0;
}

.notification-item {
  display: flex;
  align-items: flex-start;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.notification-item:last-child {
  border-bottom: none;
}

.notification-icon {
  margin-right: 10px;
  margin-top: 2px;
}

.notification-content {
  flex: 1;
}

.notification-title {
  font-size: 0.9em;
  color: #333;
  margin-bottom: 5px;
  line-height: 1.4;
}

.notification-time {
  font-size: 0.8em;
  color: #999;
}
</style>
  