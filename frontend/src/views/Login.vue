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
        <el-form-item label="验证码">
          <div style="display: flex; align-items: center; gap: 10px;">
            <el-input v-model="loginForm.captcha" style="flex: 1;" />
            <img :src="captchaImage" @click="refreshCaptcha" style="height: 40px; cursor: pointer;" alt="验证码" />
          </div>
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
          <el-checkbox v-model="rememberPassword">记住密码</el-checkbox>
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
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { ElMessage } from "element-plus";
import { onUnmounted } from 'vue'

const router = useRouter()
const loginForm = ref({
  username: '',
  password: '',
  captcha: '',
  userType: 'RESEARCHER'
})
const errorMsg = ref('')
const captchaImage = ref('')
const captchaKey = ref('')
const rememberPassword = ref(false)

// 获取验证码
const refreshCaptcha = async () => {
  try {
    const response = await axios.get('http://localhost:8080/api/captcha', {
      responseType: 'blob'
    });

    // 从响应头获取验证码key
    const key = response.headers['captcha-key'] ||
        response.headers['Captcha-Key'];

    if (key) {
      captchaKey.value = key;
    } else {
      throw new Error('未能获取验证码Key');
    }

    // 释放旧图片URL
    if (captchaImage.value) URL.revokeObjectURL(captchaImage.value);

    // 生成新图片URL
    captchaImage.value = URL.createObjectURL(response.data);
  } catch (error) {
    console.error('验证码加载失败:', error);
    ElMessage.error(`验证码加载失败: ${error.message}`);
  }
};
// 在组件卸载时释放资源
onUnmounted(() => {
  if (captchaImage.value) {
    URL.revokeObjectURL(captchaImage.value)
  }
})
onMounted(() => {
  const savedPassword = localStorage.getItem('rememberedPassword')
  if (savedPassword) {
    loginForm.value.password = savedPassword
    rememberPassword.value = true
  }
  // 初始化时获取验证码
  refreshCaptcha()
})

const handleLogin = async () => {
  if (!loginForm.value.captcha) {
    errorMsg.value = '请输入验证码'
    return
  }

  try {
    const res = await axios.post('http://localhost:8080/api/login', {
      username: loginForm.value.username,
      password: loginForm.value.password,
      captcha: loginForm.value.captcha,
      captchaKey: captchaKey.value,
      userType: loginForm.value.userType
    }, {
      headers: {
        'Captcha-Key': captchaKey.value // 同时在header中传递
      }
    })
    // 获取服务器返回的角色类型
    const serverRole = res.data.role
    if (!isRoleMatch(loginForm.value.userType, serverRole)) {
      errorMsg.value = '用户类型不匹配，请选择正确的用户类型'
      return
    }
    ElMessage.success('登录成功')
    errorMsg.value = ''
    const userInfo = {
      username: loginForm.value.username,
      real_name: res.data.real_name || loginForm.value.username,
      role: serverRole,
      userType: loginForm.value.userType
    }
    localStorage.setItem('currentUser', JSON.stringify(userInfo))
    localStorage.setItem('username', loginForm.value.username)

    if (rememberPassword.value) {
      localStorage.setItem('rememberedPassword', loginForm.value.password)
    } else {
      localStorage.removeItem('rememberedPassword')
    }

    // 根据角色跳转
    switch(serverRole) {
      case 'APPROVER':
        router.push('/rd')
        break
      default:
        await router.push('/user')
    }

    // 登录成功后刷新验证码
    refreshCaptcha()
  } catch (err) {
    errorMsg.value = err.response?.data?.message || '登录失败'
    // 登录失败后刷新验证码
    refreshCaptcha()
  }
}

const isRoleMatch = (selectedUserType, serverRole) => {
  return selectedUserType === serverRole
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
