<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Search, Document, Collection, Plus } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()

const stats = ref({ compounds: 0, experiments: 0, literature: 0 })
const recentActivities = ref([])

// 获取统计数据（可根据实际接口调整）
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/stats/dashboard')
    if (res.data.code === 200) {
      const data = res.data.data
      stats.value = {
        compounds: data.rd?.compounds || 0,
        experiments: data.rd?.experiments || 0,
        literature: data.rd?.literature || 0
      }
    }
  } catch (error) {
    console.error("获取数据失败", error)
  }
}

// 获取最近活动（用sys_permission表结构模拟）
const getRecentActivities = async () => {
  // 这里用模拟数据，实际可用axios.get('/api/permission/list')等
  recentActivities.value = [
    {
      id: 1,
      permissionName: '查看化合物',
      description: '允许用户查看化合物信息',
      createTime: '2025-07-22T10:00:00',
      icon: 'Search',
      color: '#409EFF'
    },
    {
      id: 2,
      permissionName: '编辑实验',
      description: '允许用户编辑实验记录',
      createTime: '2025-07-21T15:30:00',
      icon: 'Document',
      color: '#67C23A'
    },
    {
      id: 3,
      permissionName: '导入文献',
      description: '允许用户导入文献资料',
      createTime: '2025-07-20T09:45:00',
      icon: 'Collection',
      color: '#E6A23C'
    }
  ]
}

// 跳转
const goToCompounds = () => router.push('/rd/compounds')
const goToExperiments = () => router.push('/rd/experiments')
const goToLiterature = () => router.push('/rd/literature')

// 快捷操作
const quickAction = (action) => {
  const actionRoutes = {
    addCompound: '/rd/compounds',
    addExperiment: '/rd/experiments',
    addLiterature: '/rd/literature'
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
  <div class="rd-home">
    <div class="page-header">
      <h2>研发管理</h2>
      <p>管理化合物、实验记录和文献资料</p>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="8">
        <el-card class="stat-card" @click="goToCompounds">
          <div class="stat-icon">
            <el-icon :size="40" color="#409EFF"><Search /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.compounds || 0 }}</div>
            <div class="stat-label">化合物</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card" @click="goToExperiments">
          <div class="stat-icon">
            <el-icon :size="40" color="#67C23A"><Document /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.experiments || 0 }}</div>
            <div class="stat-label">实验记录</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card" @click="goToLiterature">
          <div class="stat-icon">
            <el-icon :size="40" color="#E6A23C"><Collection /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.literature || 0 }}</div>
            <div class="stat-label">文献资料</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 功能模块 -->
    <el-row :gutter="20" class="modules-row">
      <el-col :span="8">
        <el-card class="module-card" @click="goToCompounds">
          <div class="module-header">
            <el-icon :size="32" color="#409EFF"><Search /></el-icon>
            <h3>化合物管理</h3>
          </div>
          <div class="module-content">
            <p>管理化合物信息，包括分子式、结构、性质等</p>
            <ul>
              <li>化合物录入和编辑</li>
              <li>化合物检索</li>
              <li>化合物统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="primary" @click.stop="goToCompounds">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="module-card" @click="goToExperiments">
          <div class="module-header">
            <el-icon :size="32" color="#67C23A"><Document /></el-icon>
            <h3>实验管理</h3>
          </div>
          <div class="module-content">
            <p>管理实验记录，包括实验方案、实验数据、实验结论等</p>
            <ul>
              <li>实验记录录入和编辑</li>
              <li>实验进度跟踪</li>
              <li>实验统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="success" @click.stop="goToExperiments">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="module-card" @click="goToLiterature">
          <div class="module-header">
            <el-icon :size="32" color="#E6A23C"><Collection /></el-icon>
            <h3>文献管理</h3>
          </div>
          <div class="module-content">
            <p>管理文献资料，包括文献检索、文献归档、引用管理等</p>
            <ul>
              <li>文献录入和编辑</li>
              <li>文献检索</li>
              <li>文献统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="warning" @click.stop="goToLiterature">进入管理</el-button>
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
          <el-button type="primary" class="quick-action-btn" @click="quickAction('addCompound')">
            <el-icon><Plus /></el-icon>
            新增化合物
          </el-button>
        </el-col>
        <el-col :span="8">
          <el-button type="success" class="quick-action-btn" @click="quickAction('addExperiment')">
            <el-icon><Document /></el-icon>
            新增实验
          </el-button>
        </el-col>
        <el-col :span="8">
          <el-button type="warning" class="quick-action-btn" @click="quickAction('addLiterature')">
            <el-icon><Collection /></el-icon>
            新增文献
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
            <div class="activity-title">{{ activity.permissionName }}</div>
            <div class="activity-time">{{ formatDate(activity.createTime) }}</div>
            <div class="activity-desc">{{ activity.description }}</div>
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
.rd-home {
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