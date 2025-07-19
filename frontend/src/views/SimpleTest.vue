<template>
  <div class="simple-test">
    <el-card>
      <template #header>
        <h2>简单测试页面</h2>
      </template>
      
      <div class="test-section">
        <h3>1. 基础功能测试</h3>
        <el-button type="primary" @click="testBasic">测试基础功能</el-button>
        <div v-if="basicResult" class="result">
          <p>{{ basicResult }}</p>
        </div>
      </div>

      <div class="test-section">
        <h3>2. API连接测试</h3>
        <el-button type="success" @click="testAPI">测试API连接</el-button>
        <div v-if="apiResult" class="result">
          <pre>{{ JSON.stringify(apiResult, null, 2) }}</pre>
        </div>
      </div>

      <div class="test-section">
        <h3>3. 数据获取测试</h3>
        <el-button type="warning" @click="testData">获取测试数据</el-button>
        <div v-if="dataResult" class="result">
          <h4>药品数据 ({{ dataResult.drugs?.length || 0 }} 条)</h4>
          <div v-for="drug in dataResult.drugs" :key="drug.id" class="drug-item">
            <strong>{{ drug.name }}</strong> - ¥{{ drug.price }}
          </div>
          
          <h4>新闻数据 ({{ dataResult.news?.length || 0 }} 条)</h4>
          <div v-for="news in dataResult.news" :key="news.id" class="news-item">
            <strong>{{ news.title }}</strong>
          </div>
        </div>
      </div>

      <div class="test-section">
        <h3>4. 页面导航</h3>
        <el-button @click="goToUserHome">用户主页</el-button>
        <el-button @click="goToLogin">登录页面</el-button>
        <el-button @click="goToTest">完整测试页面</el-button>
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

const basicResult = ref('')
const apiResult = ref(null)
const dataResult = ref(null)

const testBasic = () => {
  basicResult.value = '基础功能正常！Vue 3 + Element Plus 工作正常。'
  ElMessage.success('基础功能测试通过！')
}

const testAPI = async () => {
  try {
    const response = await axios.get('http://localhost:8080/api/test/simple')
    apiResult.value = response.data
    ElMessage.success('API连接测试通过！')
  } catch (error) {
    apiResult.value = { error: error.message }
    ElMessage.error('API连接失败：' + error.message)
  }
}

const testData = async () => {
  try {
    const response = await axios.get('http://localhost:8080/api/test/database')
    dataResult.value = response.data.data
    ElMessage.success('数据获取测试通过！')
  } catch (error) {
    dataResult.value = { error: error.message }
    ElMessage.error('数据获取失败：' + error.message)
  }
}

const goToUserHome = () => {
  router.push('/user')
}

const goToLogin = () => {
  router.push('/login')
}

const goToTest = () => {
  router.push('/test')
}
</script>

<style scoped>
.simple-test {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
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
}

.result pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
}

.drug-item, .news-item {
  margin: 5px 0;
  padding: 5px;
  background: white;
  border-radius: 4px;
}

.el-button {
  margin-right: 10px;
  margin-bottom: 10px;
}
</style> 