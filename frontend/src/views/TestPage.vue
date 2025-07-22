<template>
  <div class="test-page">
    <el-card class="test-card">
      <template #header>
        <h2>系统测试页面</h2>
      </template>
      
      <div class="test-section">
        <h3>1. 健康检查</h3>
        <el-button type="primary" @click="testHealth" :loading="healthLoading">
          测试后端服务
        </el-button>
        <div v-if="healthResult" class="result">
          <pre>{{ JSON.stringify(healthResult, null, 2) }}</pre>
        </div>
      </div>

      <div class="test-section">
        <h3>2. 数据库连接测试</h3>
        <el-button type="success" @click="testDatabase" :loading="dbLoading">
          测试数据库连接
        </el-button>
        <div v-if="dbResult" class="result">
          <pre>{{ JSON.stringify(dbResult, null, 2) }}</pre>
        </div>
      </div>

      <div class="test-section">
        <h3>3. API接口测试</h3>
        <el-button type="warning" @click="testAPIs" :loading="apiLoading">
          测试所有API
        </el-button>
        <div v-if="apiResults.length > 0" class="result">
          <div v-for="(result, index) in apiResults" :key="index" class="api-result">
            <h4>{{ result.name }}</h4>
            <pre>{{ JSON.stringify(result.data, null, 2) }}</pre>
          </div>
        </div>
      </div>

      <div class="test-section">
        <h3>4. 快速导航</h3>
        <el-button @click="goToUserHome">用户主页</el-button>
        <el-button @click="goToLogin">登录页面</el-button>
        <el-button @click="goToRegister">注册页面</el-button>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import axios from 'axios'

const router = useRouter()

const healthLoading = ref(false)
const dbLoading = ref(false)
const apiLoading = ref(false)
const healthResult = ref(null)
const dbResult = ref(null)
const apiResults = ref([])

const testHealth = async () => {
  healthLoading.value = true
  try {
    const response = await axios.get('http://localhost:8080/api/test/health')
    healthResult.value = response.data
    ElMessage.success('健康检查通过！')
  } catch (error) {
    ElMessage.error('健康检查失败：' + error.message)
    healthResult.value = { error: error.message }
  } finally {
    healthLoading.value = false
  }
}

const testDatabase = async () => {
  dbLoading.value = true
  try {
    const response = await axios.get('http://localhost:8080/api/test/database')
    dbResult.value = response.data
    if (response.data.data.databaseStatus === 'CONNECTED') {
      ElMessage.success('数据库连接正常！')
    } else {
      ElMessage.error('数据库连接失败！')
    }
  } catch (error) {
    ElMessage.error('数据库测试失败：' + error.message)
    dbResult.value = { error: error.message }
  } finally {
    dbLoading.value = false
  }
}

const testAPIs = async () => {
  apiLoading.value = true
  apiResults.value = []
  
  const apis = [
    { name: '获取热门药品', url: '/api/drugs/hot' },
    { name: '获取最新新闻', url: '/api/news/latest?limit=3' },
    { name: '搜索药品', url: '/api/drugs/search?keyword=感冒' },
    { name: '获取所有药品', url: '/api/drugs' },
    { name: '获取所有新闻', url: '/api/news' }
  ]

  for (const api of apis) {
    try {
      const response = await axios.get(`http://localhost:8080${api.url}`)
      apiResults.value.push({
        name: api.name,
        data: response.data,
        status: 'success'
      })
    } catch (error) {
      apiResults.value.push({
        name: api.name,
        data: { error: error.message },
        status: 'error'
      })
    }
  }
  
  apiLoading.value = false
  ElMessage.success('API测试完成！')
}

const goToUserHome = () => {
  router.push('/user')
}

const goToLogin = () => {
  router.push('/login')
}

const goToRegister = () => {
  router.push('/register')
}
</script>

<style scoped>
.test-page {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.test-card {
  margin-bottom: 20px;
}

.test-section {
  margin-bottom: 30px;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
}

.test-section h3 {
  margin-top: 0;
  color: #409EFF;
}

.result {
  margin-top: 15px;
  padding: 15px;
  background-color: #f5f5f5;
  border-radius: 4px;
  overflow-x: auto;
}

.result pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
}

.api-result {
  margin-bottom: 20px;
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.api-result h4 {
  margin-top: 0;
  color: #67C23A;
}

.el-button {
  margin-right: 10px;
  margin-bottom: 10px;
}
</style> 