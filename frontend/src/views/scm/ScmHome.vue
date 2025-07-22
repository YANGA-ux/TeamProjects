<template>
  <div class="scm-home">
    <div class="page-header">
      <h2>供应链管理</h2>
      <p>管理物料、供应商和采购流程</p>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="12">
        <el-card class="stat-card" @click="goToMaterials">
          <div class="stat-icon">
            <el-icon :size="40" color="#409EFF"><Box /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.materials || 0 }}</div>
            <div class="stat-label">物料</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="stat-card" @click="goToSuppliers">
          <div class="stat-icon">
            <el-icon :size="40" color="#67C23A"><UserFilled /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.suppliers || 0 }}</div>
            <div class="stat-label">供应商</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 功能模块 -->
    <el-row :gutter="20" class="modules-row">
      <el-col :span="12">
        <el-card class="module-card" @click="goToMaterials">
          <div class="module-header">
            <el-icon :size="32" color="#409EFF"><Box /></el-icon>
            <h3>物料管理</h3>
          </div>
          <div class="module-content">
            <p>管理所有物料信息，包括物料编码、名称、库存、供应商等</p>
            <ul>
              <li>物料录入和编辑</li>
              <li>库存管理</li>
              <li>物料统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="primary" @click.stop="goToMaterials">进入管理</el-button>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="module-card" @click="goToSuppliers">
          <div class="module-header">
            <el-icon :size="32" color="#67C23A"><UserFilled /></el-icon>
            <h3>供应商管理</h3>
          </div>
          <div class="module-content">
            <p>管理供应商信息，包括供应商编码、名称、联系方式、资质等</p>
            <ul>
              <li>供应商录入和编辑</li>
              <li>供应商资质管理</li>
              <li>供应商统计分析</li>
            </ul>
          </div>
          <div class="module-footer">
            <el-button type="success" @click.stop="goToSuppliers">进入管理</el-button>
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
        <el-col :span="12">
          <el-button type="primary" class="quick-action-btn" @click="quickAction('addMaterial')">
            <el-icon><Box /></el-icon>
            新增物料
          </el-button>
        </el-col>
        <el-col :span="12">
          <el-button type="success" class="quick-action-btn" @click="quickAction('addSupplier')">
            <el-icon><UserFilled /></el-icon>
            新增供应商
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
            <div class="activity-desc">{{ activity.desc }}</div>
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
import { Box, UserFilled } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()
const stats = ref({ materials: 0, suppliers: 0 })
const recentActivities = ref([])

// 获取统计数据
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/stats/dashboard')
    if (res.data.code === 200) {
      const data = res.data.data
      stats.value = {
        materials: data.scm?.materials || 0,
        suppliers: data.scm?.suppliers || 0
      }
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

// 获取最近活动（假设有/api/scm/activity/list接口）
const getRecentActivities = async () => {
  try {
    // 这里假设有后端接口 /api/scm/activity/list，返回 [{id, title, time, desc, icon, color}]
    const res = await axios.get('http://localhost:8080/api/scm/activity/list')
    if (res.data.code === 200) {
      recentActivities.value = res.data.data
    }
  } catch (error) {
    console.error('获取最近活动失败:', error)
    recentActivities.value = []
  }
}

const goToMaterials = () => router.push('/scm/materials')
const goToSuppliers = () => router.push('/scm/suppliers')

const quickAction = (action) => {
  const actionRoutes = {
    addMaterial: '/scm/materials',
    addSupplier: '/scm/suppliers'
  }
  const route = actionRoutes[action]
  if (route) {
    router.push(route)
    ElMessage.success('正在跳转到相关页面...')
  } else {
    ElMessage.info(`${action}功能开发中...`)
  }
}

const refreshActivities = async () => {
  await getRecentActivities()
  ElMessage.success('活动已刷新')
}

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
.scm-home {
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