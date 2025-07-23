<template>
  <!-- 最外层容器，负责背景、居中逻辑 -->
  <div class="page-wrapper">
    <h1 class="page-title">生物医药数字信息系统用户登录</h1>
    <!-- 登录表单容器 -->
    <div class="login-container">
      <el-form :model="loginForm" @submit.prevent="handleLogin" style="width: 300px;">
        <el-form-item label="用户名">
          <el-input v-model="loginForm.username" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="loginForm.password" type="password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="用户类型">
          <el-select v-model="loginForm.userType" placeholder="请选择用户类型">
            <el-option label="研究员" value="RESEARCHER"></el-option>
            <el-option label="管理员" value="ADMIN"></el-option>
            <el-option label="实验员" value="LAB_TECHNICIAN"></el-option>
            <el-option label="审批人员" value="APPROVER"></el-option>
            <el-option label="监管人员" value="SUPERVISOR"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleLogin" style="width: 100%;">登录</el-button>
        </el-form-item>

        <el-form-item>
          <el-checkbox v-model="rememberPassword" >记住密码</el-checkbox>
        </el-form-item>

      </el-form>
      <div v-if="errorMsg" style="color:red;text-align:center;">{{ errorMsg }}</div>
      <div style="text-align:center;margin-top:10px;">
        <el-link type="primary" @click="goChangePassword">修改密码</el-link>
      </div>
      <div style="text-align:center;margin-top:10px;">
        <el-link type="primary" @click="goRegister">注册</el-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const loginForm = ref({
  username: '',
  password: '',
  userType: 'RESEARCHER'
})
const errorMsg = ref('')

const rememberPassword = ref(false); // 新增：控制是否记住密码
onMounted(() => {
  // 页面加载时，若之前存过密码且勾选记住，自动填充
  const savedPassword = localStorage.getItem('rememberedPassword');
  if (savedPassword) {
    loginForm.value.password = savedPassword;
    rememberPassword.value = true;
  }
});

const handleLogin = async () => {
  try {
    const res = await axios.post('http://localhost:8080/api/login', loginForm.value)
    alert('登录成功')
    errorMsg.value = ''
    const userType = res.data.userType || loginForm.value.userType;
    const userInfo = {
      username: loginForm.value.username,
      real_name: loginForm.value.username,
      role: mapUserTypeToRole(userType),
      userType: userType
    }
    localStorage.setItem('currentUser', JSON.stringify(userInfo))

    // 新增：记住密码逻辑
    if (rememberPassword.value) {
      localStorage.setItem('rememberedPassword', loginForm.value.password);
    } else {
      localStorage.removeItem('rememberedPassword');
    }

    router.push('/user')
  } catch (err) {
    errorMsg.value = '用户名或密码错误'
  }
}
const mapUserTypeToRole = (userType) => {
  switch(userType) {
    case 'LAB_TECHNICIAN':
    case 'ADMIN':
      return 'ADMIN';
    default:
      return 'RESEARCHER';
  }
}

const goChangePassword = () => {
  router.push('/change-password')
}
const goRegister = () => {
  router.push('/register')
}
</script>

<style scoped>
/* 最外层容器：控制垂直+水平居中，同时排列标题和表单 */
.page-wrapper {
  min-height: 100vh;
  background-image: url('public/background.png');
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  /* 开启 Flex 布局，让子元素垂直排列 */
  display: flex;
  flex-direction: column;
  /* 子元素水平居中 */
  align-items: center;
  /* 子元素垂直方向居中（可根据需求调整，若想让整体靠上/下，可换用 flex-start/flex-end ） */
  justify-content: center;
}

/* 标题样式：可按需调整间距 */
.page-title {
  margin-bottom: 40px; /* 标题与表单之间的间距 */
  font-size: 24px;
}

/* 登录表单容器样式 */
.login-container {
  width: 400px;
  padding: 20px;
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
