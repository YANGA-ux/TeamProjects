<template>
  <div class="register-container">
    <el-form :model="form" @submit.prevent="handleRegister" style="width: 300px; margin: 100px auto;">
      <el-form-item label="用户名">
        <el-input v-model="form.username" autocomplete="off" />
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="form.password" type="password" autocomplete="off" />
      </el-form-item>
      <el-form-item label="真实姓名">
        <el-input v-model="form.realName" autocomplete="off" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleRegister" style="width: 100%;">注册</el-button>
      </el-form-item>
    </el-form>
    <div v-if="msg" :style="{color: msgColor, textAlign: 'center'}">{{ msg }}</div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()
const form = ref({
  username: '',
  password: '',
  realName: ''
})
const msg = ref('')
const msgColor = ref('red')

const handleRegister = async () => {
  try {
    await axios.post('http://localhost:8080/api/register', form.value)
    msg.value = '注册成功'
    msgColor.value = 'green'
    setTimeout(() => router.push('/login'), 1000)
  } catch (err) {
    msg.value = '用户名已存在'
    msgColor.value = 'red'
  }
}
</script>