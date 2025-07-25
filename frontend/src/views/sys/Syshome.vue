<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock, Monitor, Plus } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()

const stats = ref({ users: 0, roles: 0, online: 0 })
const recentActivities = ref([])

// 获取统计数据
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/stats/dashboard')
    if (res.data.code === 200) {
      stats.value = {
        users: res.data.data.users || 0,
        roles: res.data.data.roles || 0,
        online: res.data.data.online || 0
      }
    }
  } catch (error) {
    console.error("获取数据失败", error)
  }
}

// 获取最近活动
const getRecentActivities = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/system/activities')
    if (res.data.code === 200) {
      recentActivities.value = res.data.data
    }
  } catch (error) {
    console.error("获取活动失败", error)
  }
}

// 跳转
const goToUsers = () => router.push('/system/users')
const goToRoles = () => router.push('/system/roles')
const goToMonitor = () => router.push('/system/monitor')

// 快捷操作
const quickAction = (action) => {
  const actionRoutes = {
    addUser: '/system/users/add',
    addRole: '/system/roles/add',
    viewLogs: '/system/logs'
  }
  const route = actionRoutes[action]
  if (route) {
    router.push(route)
    ElMessage.success('正在跳转到相关页面...')
  } else {
    ElMessage.info(`${action}功能开发中...`)
  }
}

// 刷新活动
const refreshActivities = async () => {
  await getRecentActivities()
  ElMessage.success('活动已刷新')
}

// 格式化日期
const formatDate = (str) => {
  if (!str) return ''
  return new Date(str).toLocaleString('zh-CN')
}

onMounted(() => {
  getStats()
  getRecentActivities()
})
</script>

<template>
  <div class="system-home">
    <div class="page-header">
      <h2>系统管理</h2>
      <p>用户管理、权限管理、系统监控</p>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="8">
        <el-card class="stat-card" @click="goToUsers">
          <div class="stat-icon">
            <el-icon :size="40" color="#409EFF"><User /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.users || 0 }}</div>
            <div class="stat-label">用户</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card" @click="goToRoles">
          <div class="stat-icon">
            <el-icon :size="40" color="#67C23A"><Lock /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.roles || 0 }}</div>
            <div class="stat-label">角色</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card" @click="goToMonitor">
          <div class="stat-icon">
            <el-icon :size="40" color="#E6A23C"><Monitor /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.online || 0 }}</div>
            <div class="stat-label">在线用户</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 功能模块 -->
    <el-row :gutter="20" class="modules-row">
      <el-col :span="8">
        <el-card class="module-card" @click="goToUsers">
          <div class="module-header">
            <el-icon :size="32" color="#409EFF"><User /></el-icon>
            <h3>用户管理</h3>
          </div>
          <div class="module-content">
            <p>管理系统用户，包括创建、编辑、禁用用户账户</p>
            <ul>
              <li>用户账户管理</li>
              <li>用户权限分配</li>
              <li>用户登录记录</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="primary" @click.stop="goToUsers">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="module-card" @click="goToRoles">
          <div class="module-header">
            <el-icon :size="32" color="#67C23A"><Lock /></el-icon>
            <h3>权限管理</h3>
          </div>
          <div class="module-content">
            <p>管理角色和权限，控制用户对系统功能的访问</p>
            <ul>
              <li>角色创建和编辑</li>
              <li>权限分配</li>
              <li>权限组管理</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="success" @click.stop="goToRoles">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="module-card" @click="goToMonitor">
          <div class="module-header">
            <el-icon :size="32" color="#E6A23C"><Monitor /></el-icon>
            <h3>系统监控</h3>
          </div>
          <div class="module-content">
            <p>监控系统运行状态，查看日志和性能指标</p>
            <ul>
              <li>系统性能监控</li>
              <li>操作日志查看</li>
              <li>异常报警</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="warning" @click.stop="goToMonitor">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 快捷操作 -->
    <el-card class="quick-actions">
      <template #header>
        <div class="card-header">
          <span>快捷操作</span>
        </div>
      </template>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-button type="primary" class="quick-action-btn" @click="quickAction('addUser')">
            <el-icon><Plus /></el-icon>
            新增用户
          </el-button>
        </el-col>
        <el-col :span="8">
          <el-button type="success" class="quick-action-btn" @click="quickAction('addRole')">
            <el-icon><Lock /></el-icon>
            新增角色
          </el-button>
        </el-col>
        <el-col :span="8">
          <el-button type="warning" class="quick-action-btn" @click="quickAction('viewLogs')">
            <el-icon><Monitor /></el-icon>
            查看日志
          </el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 最近活动 -->
    <el-card class="recent-activities">
      <template #header>
        <div class="card-header">
          <span>最近活动</span>
          <el-button link @click="refreshActivities">刷新</el-button>
        </div>
      </template>
      <div v-if="recentActivities.length > 0">
        <div v-for="activity in recentActivities" :key="activity.id" class="activity-item">
          <div class="activity-icon">
            <el-icon :size="20" :color="activity.color">
              <component :is="activity.icon" />
            </el-icon>
          </div>
          <div class="activity-content">
            <div class="activity-title">{{ activity.action }}</div>
            <div class="activity-time">{{ formatDate(activity.time) }}</div>
            <div class="activity-desc">{{ activity.user }} {{ activity.details }}</div>
          </div>
        </div>
      </div>
      <div v-else class="no-activity">
        暂无最近活动
      </div>
    </el-card>
  </div>
</template>

<style scoped>
.system-home {
  padding: 20px;
}
.page-header {
  text-align: center;
  margin-bottom: 30px;
}
.page-header h2 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 2em;
}
.page-header p {
  margin: 0;
  color: #666;
  font-size: 1.1em;
}
.stats-row {
  margin-bottom: 30px;
}
.stat-card {
  cursor: pointer;
  transition: transform 0.3s;
  text-align: center;
  padding: 20px;
}
.stat-card:hover {
  transform: translateY(-5px);
}
.stat-icon {
  margin-bottom: 15px;
}
.stat-content {
  text-align: center;
}
.stat-number {
  font-size: 2em;
  font-weight: bold;
  color: #333;
  margin-bottom: 5px;
}
.stat-label {
  color: #666;
  font-size: 0.9em;
}
.modules-row {
  margin-bottom: 30px;
}
.module-card {
  cursor: pointer;
  transition: transform 0.3s;
  height: 300px;
  display: flex;
  flex-direction: column;
}
.module-card:hover {
  transform: translateY(-5px);
}
.module-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}
.module-header h3 {
  margin: 0 0 0 15px;
  color: #333;
}
.module-content {
  flex: 1;
}
.module-content p {
  color: #666;
  margin-bottom: 15px;
  line-height: 1.6;
}
.module-content ul {
  color: #666;
  padding-left: 20px;
}
.module-content li {
  margin-bottom: 8px;
}
.module-footer {
  text-align: center;
  margin-top: 20px;
}
.quick-actions {
  margin-bottom: 30px;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
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
.recent-activities {
  margin-bottom: 30px;
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
.activity-desc {
  font-size: 0.9em;
  color: #666;
  margin-bottom: 2px;
}
.no-activity {
  text-align: center;
  color: #999;
  padding: 40px 0;
}
</style>