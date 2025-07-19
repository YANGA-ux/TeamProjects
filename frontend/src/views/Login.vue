<template>
  <div class="login-container">
    <el-form :model="loginForm" @submit.prevent="handleLogin" style="width: 300px; margin: 100px auto;">
      <el-form-item label="用户名">
        <el-input v-model="loginForm.username" autocomplete="off" />
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="loginForm.password" type="password" autocomplete="off" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleLogin" style="width: 100%;">登录</el-button>
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
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const loginForm = ref({
  username: '',
  password: ''
})
const errorMsg = ref('')

const handleLogin = async () => {
  try {
    const res = await axios.post('http://localhost:8080/api/login', loginForm.value)
    alert('登录成功')
    errorMsg.value = ''
    // 登录成功后跳转到用户主页
    router.push('/user')
  } catch (err) {
    errorMsg.value = '用户名或密码错误'
  }
}

const goChangePassword = () => {
  router.push('/change-password')
}
const goRegister = () => {
  router.push('/register')
}
</script>