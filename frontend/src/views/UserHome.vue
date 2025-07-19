<template>
    <div class="user-home">
      <!-- 顶部导航栏 -->
      <el-header class="header">
        <div class="header-content">
          <div class="logo">
            <h2>生物医药系统</h2>
          </div>
          <div class="search-box">
            <el-input
              v-model="searchKeyword"
              placeholder="搜索药品..."
              @keyup.enter="searchDrugs"
              style="width: 300px"
            >
              <template #append>
                <el-button @click="searchDrugs">
                  <el-icon><Search /></el-icon>
                </el-button>
              </template>
            </el-input>
          </div>
          <div class="user-info">
            <el-dropdown>
              <span class="user-dropdown">
                <el-avatar :size="32" icon="UserFilled" />
                <span style="margin-left: 8px">{{ userInfo.real_name || userInfo.username }}</span>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item @click="showProfile">个人信息</el-dropdown-item>
                  <el-dropdown-item @click="showOrders">我的订单</el-dropdown-item>
                  <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </div>
      </el-header>
  
      <!-- 主要内容区域 -->
      <el-main class="main-content">
        <!-- 轮播图 -->
        <el-carousel height="300px" class="banner">
          <el-carousel-item v-for="item in banners" :key="item.id">
            <div class="banner-item" :style="{ backgroundImage: `url(${item.image || '/default-banner.png'})` }">
              <div class="banner-content">
                <h3>{{ item.title }}</h3>
                <p>{{ item.description }}</p>
              </div>
            </div>
          </el-carousel-item>
        </el-carousel>
  
        <!-- 药品分类 -->
        <div class="category-section">
          <h3>药品分类</h3>
          <el-row :gutter="20">
            <el-col :span="6" v-for="category in categories" :key="category.id">
              <el-card class="category-card" @click="selectCategory(category.name)">
                <div class="category-icon">
                  <el-icon :size="40" :color="category.color">
                    <Box v-if="category.icon === 'MedicineBox'" />
                    <FirstAidKit v-else-if="category.icon === 'FirstAidKit'" />
                    <CircleCheck v-else-if="category.icon === 'Pill'" />
                    <CircleCheck v-else-if="category.icon === 'Syringe'" />
                    <Box v-else />
                  </el-icon>
                </div>
                <h4>{{ category.name }}</h4>
                <p>{{ category.description }}</p>
              </el-card>
            </el-col>
          </el-row>
        </div>
  
        <!-- 热门药品 -->
        <div class="hot-drugs-section">
          <h3>热门药品</h3>
          <el-row :gutter="20">
            <el-col :span="6" v-for="drug in hotDrugs" :key="drug.id">
              <el-card class="drug-card" @click="showDrugDetail(drug)">
                <div class="drug-image">
                  <img :src="drug.imageUrl || '/default-drug.png'" :alt="drug.name" />
                </div>
                <div class="drug-info">
                  <h4>{{ drug.name }}</h4>
                  <p class="manufacturer">{{ drug.manufacturer }}</p>
                  <p class="price">¥{{ drug.price }}</p>
                  <el-button type="primary" size="small" @click.stop="addToCart(drug)">加入购物车</el-button>
                </div>
              </el-card>
            </el-col>
          </el-row>
        </div>
  
        <!-- 最新资讯 -->
        <div class="news-section">
          <h3>最新资讯</h3>
          <el-row :gutter="20">
            <el-col :span="12">
              <div class="news-list">
                <div
                  v-for="news in latestNews"
                  :key="news.id"
                  class="news-item"
                  @click="showNewsDetail(news)"
                >
                  <div class="news-image">
                    <img :src="news.imageUrl || '/default-news.jpg'" :alt="news.title" />
                  </div>
                  <div class="news-content">
                    <h4>{{ news.title }}</h4>
                    <p>{{ news.content.substring(0, 100) }}...</p>
                    <span class="news-time">{{ formatDate(news.publishTime) }}</span>
                  </div>
                </div>
              </div>
            </el-col>
            <el-col :span="12">
              <div class="quick-stats">
                <el-card>
                  <h4>系统统计</h4>
                  <div class="stats-item">
                    <span>在线用户：</span>
                    <span class="stat-number">{{ stats.onlineUsers }}</span>
                  </div>
                  <div class="stats-item">
                    <span>今日订单：</span>
                    <span class="stat-number">{{ stats.todayOrders }}</span>
                  </div>
                  <div class="stats-item">
                    <span>药品总数：</span>
                    <span class="stat-number">{{ stats.totalDrugs }}</span>
                  </div>
                </el-card>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-main>
  
      <!-- 药品详情对话框 -->
      <el-dialog v-model="drugDetailVisible" title="药品详情" width="600px">
        <div v-if="selectedDrug" class="drug-detail">
          <div class="drug-detail-image">
            <img :src="selectedDrug.imageUrl || '/default-drug.png'" :alt="selectedDrug.name" />
          </div>
          <div class="drug-detail-info">
            <h3>{{ selectedDrug.name }}</h3>
            <p><strong>通用名：</strong>{{ selectedDrug.genericName }}</p>
            <p><strong>生产厂家：</strong>{{ selectedDrug.manufacturer }}</p>
            <p><strong>剂型：</strong>{{ selectedDrug.dosageForm }}</p>
            <p><strong>规格：</strong>{{ selectedDrug.strength }}</p>
            <p><strong>价格：</strong>¥{{ selectedDrug.price }}</p>
            <p><strong>库存：</strong>{{ selectedDrug.stock }}</p>
            <p><strong>描述：</strong>{{ selectedDrug.description }}</p>
          </div>
          <div class="drug-detail-actions">
            <el-input-number v-model="purchaseQuantity" :min="1" :max="selectedDrug.stock" />
            <el-button type="primary" @click="purchaseDrug">立即购买</el-button>
          </div>
        </div>
      </el-dialog>
  
      <!-- 新闻详情对话框 -->
      <el-dialog v-model="newsDetailVisible" title="新闻详情" width="800px">
        <div v-if="selectedNews" class="news-detail">
          <h2>{{ selectedNews.title }}</h2>
          <div class="news-meta">
            <span>作者：{{ selectedNews.author }}</span>
            <span>发布时间：{{ formatDate(selectedNews.publishTime) }}</span>
            <span>分类：{{ selectedNews.category }}</span>
          </div>
          <div class="news-content" v-html="selectedNews.content"></div>
        </div>
      </el-dialog>
    </div>
  </template>
  
  <script setup>
  import { ref, reactive, onMounted } from 'vue'
  import { useRouter } from 'vue-router'
  import { ElMessage } from 'element-plus'
  import {
  Search,
  UserFilled,
  FirstAidKit,
  Box,
  CircleCheck
} from '@element-plus/icons-vue'
  import axios from 'axios'
  
  const router = useRouter()
  
  const searchKeyword = ref('')
  const userInfo = ref({})
  const hotDrugs = ref([])
  const latestNews = ref([])
  const drugDetailVisible = ref(false)
  const newsDetailVisible = ref(false)
  const selectedDrug = ref(null)
  const selectedNews = ref(null)
  const purchaseQuantity = ref(1)
  

  
  const banners = ref([
    { id: 1, title: '专业医药服务', description: '为您提供优质的药品和专业的医药咨询服务', image: 'https://via.placeholder.com/1200x300/409EFF/FFFFFF?text=专业医药服务' },
    { id: 2, title: '品质保证', description: '所有药品均经过严格质量检验，确保安全有效', image: 'https://via.placeholder.com/1200x300/67C23A/FFFFFF?text=品质保证' },
    { id: 3, title: '快速配送', description: '专业配送团队，确保药品及时送达', image: 'https://via.placeholder.com/1200x300/E6A23C/FFFFFF?text=快速配送' }
  ])
  
  const categories = ref([
    { id: 1, name: '感冒用药', description: '感冒、发热、咳嗽等症状', icon: 'MedicineBox', color: '#409EFF' },
    { id: 2, name: '消化系统', description: '胃痛、消化不良等症状', icon: 'FirstAidKit', color: '#67C23A' },
    { id: 3, name: '心脑血管', description: '高血压、心脏病等症状', icon: 'Pill', color: '#E6A23C' },
    { id: 4, name: '外用药品', description: '皮肤、外伤等症状', icon: 'Syringe', color: '#F56C6C' }
  ])
  
  const stats = reactive({
    onlineUsers: 156,
    todayOrders: 89,
    totalDrugs: 1247
  })
  
  const searchDrugs = async () => {
    if (!searchKeyword.value.trim()) {
      ElMessage.warning('请输入搜索关键词')
      return
    }
    try {
      const res = await axios.get(`http://localhost:8080/api/drugs/search?keyword=${searchKeyword.value}`)
      if (res.data.code === 200) hotDrugs.value = res.data.data
    } catch {
      ElMessage.error('搜索失败')
    }
  }
  
  const selectCategory = async (categoryName) => {
    try {
      const res = await axios.get(`http://localhost:8080/api/drugs/category/${categoryName}`)
      if (res.data.code === 200) hotDrugs.value = res.data.data
    } catch {
      ElMessage.error('获取分类药品失败')
    }
  }
  
  const showDrugDetail = (drug) => {
    selectedDrug.value = drug
    drugDetailVisible.value = true
    purchaseQuantity.value = 1
  }
  
  const showNewsDetail = (news) => {
    selectedNews.value = news
    newsDetailVisible.value = true
  }
  
  const addToCart = (drug) => {
    ElMessage.success(`已将 ${drug.name} 加入购物车`)
  }
  
  const purchaseDrug = () => {
    if (!selectedDrug.value) return
    ElMessage.success(`购买成功！数量：${purchaseQuantity.value}`)
    drugDetailVisible.value = false
  }
  
  const showProfile = () => ElMessage.info('个人信息功能开发中...')
  const showOrders = () => ElMessage.info('订单管理功能开发中...')
  const logout = () => {
    ElMessage.success('退出登录成功')
    router.push('/login')
  }
  
  const formatDate = (str) => {
    if (!str) return ''
    return new Date(str).toLocaleDateString('zh-CN')
  }
  
  onMounted(async () => {
    userInfo.value = { username: 'user123', real_name: '张三' }
    try {
      const res = await axios.get('http://localhost:8080/api/drugs/hot')
      if (res.data.code === 200) hotDrugs.value = res.data.data
    } catch {
      hotDrugs.value = [
        { id: 1, name: '阿莫西林胶囊', manufacturer: '华北制药', price: 15.8, imageUrl: 'https://via.placeholder.com/300x200/409EFF/FFFFFF?text=阿莫西林' },
        { id: 2, name: '布洛芬片', manufacturer: '中美史克', price: 12.5, imageUrl: 'https://via.placeholder.com/300x200/67C23A/FFFFFF?text=布洛芬' }
      ]
    }
    try {
      const res = await axios.get('http://localhost:8080/api/news/latest?limit=5')
      if (res.data.code === 200) latestNews.value = res.data.data
    } catch {
      latestNews.value = [
        {
          id: 1, title: '新型疫苗研发取得突破',
          content: '科研团队在新型疫苗研发方面取得重大突破，为疫情防控提供新方案...',
          author: '医药科技', publishTime: '2024-01-15T10:00:00', imageUrl: 'https://via.placeholder.com/200x150/E6A23C/FFFFFF?text=疫苗研发'
        }
      ]
    }
  })
  </script>
  
  <style scoped>
  .user-home {
    min-height: 100vh;
    background-color: #f5f5f5;
  }
  .header { background-color: #fff; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); position: fixed; top: 0; left: 0; right: 0; z-index: 1000; }
  .header-content { display: flex; align-items: center; justify-content: space-between; max-width: 1200px; margin: 0 auto; padding: 0 20px; height: 100%; }
  .logo h2 { color: #409EFF; margin: 0; }
  .user-dropdown { display: flex; align-items: center; cursor: pointer; }
  
  .main-content { margin-top: 60px; max-width: 1200px; margin-left: auto; margin-right: auto; padding: 20px; }
  .banner { margin-bottom: 30px; border-radius: 8px; overflow: hidden; }
  .banner-item { height: 100%; background-size: cover; background-position: center; display: flex; align-items: center; justify-content: center; color: white; text-align: center; }
  .banner-content h3 { font-size: 2em; margin-bottom: 10px; }
  
  .category-section, .hot-drugs-section, .news-section { margin-bottom: 40px; }
  .category-card, .drug-card { cursor: pointer; transition: transform 0.3s; text-align: center; }
  .category-card:hover, .drug-card:hover { transform: translateY(-5px); }
  
  .drug-image { height: 150px; overflow: hidden; border-radius: 4px; }
  .drug-image img { width: 100%; height: 100%; object-fit: cover; }
  .drug-info { padding: 10px 0; }
  .drug-info h4 { margin: 0 0 5px 0; color: #333; }
  .manufacturer { color: #666; font-size: 0.9em; margin: 5px 0; }
  .price { color: #f56c6c; font-weight: bold; font-size: 1.1em; margin: 10px 0; }
  
  .news-item { display: flex; margin-bottom: 20px; padding: 15px; background: white; border-radius: 8px; cursor: pointer; transition: box-shadow 0.3s; }
  .news-item:hover { box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
  .news-image { width: 100px; height: 80px; margin-right: 15px; border-radius: 4px; overflow: hidden; }
  .news-image img { width: 100%; height: 100%; object-fit: cover; }
  .news-content h4 { margin: 0 0 8px 0; color: #333; }
  .news-content p { color: #666; margin: 0 0 8px 0; line-height: 1.4; }
  .news-time { color: #999; font-size: 0.8em; }
  
  .stats-item { display: flex; justify-content: space-between; margin-bottom: 15px; padding: 10px 0; border-bottom: 1px solid #eee; }
  .stat-number { font-weight: bold; color: #409EFF; font-size: 1.2em; }
  
  .drug-detail { display: flex; flex-direction: column; }
  .drug-detail-image { text-align: center; margin-bottom: 20px; }
  .drug-detail-image img { max-width: 200px; border-radius: 8px; }
  .drug-detail-info h3 { color: #333; margin-bottom: 15px; }
  .drug-detail-info p { margin: 5px 0; color: #555; font-size: 14px; line-height: 1.6; }
  .drug-detail-actions { margin-top: 20px; display: flex; align-items: center; gap: 10px; }
  </style>
  