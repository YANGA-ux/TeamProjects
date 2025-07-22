<template>
  <div class="production-home">
    <div class="page-header">
      <h2>生产管理</h2>
      <p>管理生产批次、质量标准和生产流程</p>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="6">
        <el-card class="stat-card" @click="goToBatches">
          <div class="stat-icon">
            <el-icon :size="40" color="#409EFF"><Box /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.batches || 0 }}</div>
            <div class="stat-label">生产批次</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card" @click="goToStandards">
          <div class="stat-icon">
            <el-icon :size="40" color="#67C23A"><Document /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.standards || 0 }}</div>
            <div class="stat-label">质量标准</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-icon">
            <el-icon :size="40" color="#E6A23C"><TrendCharts /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.inProduction || 0 }}</div>
            <div class="stat-label">生产中</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-icon">
            <el-icon :size="40" color="#F56C6C"><Warning /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.qualityCheck || 0 }}</div>
            <div class="stat-label">质检中</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 功能模块 -->
    <el-row :gutter="20" class="modules-row">
      <el-col :span="12">
        <el-card class="module-card" @click="goToBatches">
          <div class="module-header">
            <el-icon :size="32" color="#409EFF"><Box /></el-icon>
            <h3>批次管理</h3>
          </div>
          <div class="module-content">
            <p>管理生产批次信息，包括批次号、生产日期、有效期、生产线、操作员等</p>
            <ul>
              <li>批次信息录入和编辑</li>
              <li>批次状态跟踪</li>
              <li>质量评分管理</li>
              <li>批次统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="primary" @click.stop="goToBatches">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="module-card" @click="goToStandards">
          <div class="module-header">
            <el-icon :size="32" color="#67C23A"><Document /></el-icon>
            <h3>质量标准管理</h3>
          </div>
          <div class="module-content">
            <p>管理质量标准，包括标准编号、标准名称、质量要求、检测方法等</p>
            <ul>
              <li>质量标准制定</li>
              <li>标准版本管理</li>
              <li>标准状态控制</li>
              <li>标准详情查看</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="success" @click.stop="goToStandards">进入管理</el-button>
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
        <el-col :span="6">
          <el-button type="primary" class="quick-action-btn" @click="quickAction('addBatch')">
            <el-icon><Plus /></el-icon>
            新增批次
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-button type="success" class="quick-action-btn" @click="quickAction('addStandard')">
            <el-icon><Document /></el-icon>
            新增标准
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-button type="warning" class="quick-action-btn" @click="quickAction('qualityCheck')">
            <el-icon><Search /></el-icon>
            质量检查
          </el-button>
        </el-col>
        <el-col :span="6">
          <el-button type="info" class="quick-action-btn" @click="quickAction('report')">
            <el-icon><TrendCharts /></el-icon>
            生产报告
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
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Box, Document, TrendCharts, Warning, Plus, Search } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()

const stats = ref({})
const recentActivities = ref([])

// 获取统计数据
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/stats/dashboard')
    if (res.data.code === 200) {
      const data = res.data.data
      stats.value = {
        batches: data.prod?.batches || 0,
        standards: data.prod?.standards || 0,
        inProduction: 0,
        qualityCheck: 0
      }
      
      // 获取批次状态统计
      const batchStatsRes = await axios.get('http://localhost:8080/api/prod/batch/stats')
      if (batchStatsRes.data.code === 200) {
        const batchStats = batchStatsRes.data.data
        stats.value.inProduction = batchStats.inProduction || 0
        stats.value.qualityCheck = batchStats.qualityCheck || 0
      }
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

// 获取最近活动
const getRecentActivities = async () => {
  try {
    // 模拟数据
    recentActivities.value = [
      {
        id: 1,
        title: '新增生产批次 B202401008',
        time: '2024-01-22T10:30:00',
        icon: 'Box',
        color: '#409EFF'
      },
      {
        id: 2,
        title: '更新质量标准 QS009',
        time: '2024-01-22T09:15:00',
        icon: 'Document',
        color: '#67C23A'
      },
      {
        id: 3,
        title: '完成批次 B202401004 质量检测',
        time: '2024-01-22T08:45:00',
        icon: 'Search',
        color: '#E6A23C'
      },
      {
        id: 4,
        title: '拒绝批次 B202401005',
        time: '2024-01-21T16:20:00',
        icon: 'Warning',
        color: '#F56C6C'
      }
    ]
  } catch (error) {
    console.error('获取最近活动失败:', error)
  }
}

// 导航到批次管理
const goToBatches = () => {
  router.push('/prod/batches')
}

// 导航到质量标准管理
const goToStandards = () => {
  router.push('/prod/standards')
}

// 快捷操作
const quickAction = (action) => {
  const actionRoutes = {
    addBatch: '/prod/batches',
    addStandard: '/prod/standards',
    qualityCheck: '/prod/batches',
    report: '/prod/batches'
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

<style scoped>
.production-home {
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

.no-activity {
  text-align: center;
  color: #999;
  padding: 40px 0;
}
</style> 