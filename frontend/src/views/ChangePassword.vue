<template>
  <div class="change-password-container">
    <el-form :model="form" @submit.prevent="handleChangePassword" style="width: 300px; margin: 100px auto;">
      <el-form-item label="用户名">
        <el-input v-model="form.username" autocomplete="off" />
      </el-form-item>
      <el-form-item label="原密码">
        <el-input v-model="form.oldPassword" type="password" autocomplete="off" />
      </el-form-item>
      <el-form-item label="新密码">
        <el-input v-model="form.newPassword" type="password" autocomplete="off" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleChangePassword" style="width: 100%;">修改密码</el-button>
      </el-form-item>
    </el-form>
    <div v-if="msg" :style="{color: msgColor, textAlign: 'center'}">{{ msg }}</div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const form = ref({
  username: '',
  oldPassword: '',
  newPassword: ''
})
const msg = ref('')
const msgColor = ref('red')

const handleChangePassword = async () => {
  try {
    await axios.post('http://localhost:8080/api/change-password', form.value)
    msg.value = '修改成功'
    msgColor.value = 'green'
  } catch (err) {
    msg.value = '原密码错误或用户不存在'
    msgColor.value = 'red'
  }
}
</script>