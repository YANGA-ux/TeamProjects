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
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import {ElMessage} from "element-plus";
const router = useRouter()
const loginForm = ref({
  username: '',
  password: '',
  userType: 'RESEARCHER' // 前端选择的用户类型
})
const errorMsg = ref('')

const rememberPassword = ref(false);
onMounted(() => {
  const savedPassword = localStorage.getItem('rememberedPassword');
  if (savedPassword) {
    loginForm.value.password = savedPassword;
    rememberPassword.value = true;
  }
});
const handleLogin = async () => {
  try {
    const res = await axios.post('http://localhost:8080/api/login', {
      username: loginForm.value.username,
      password: loginForm.value.password
    })
    // 获取服务器返回的角色类型（数据库中的role字段）
    const serverRole = res.data.role;
    // 验证前端选择的用户类型是否与服务器返回的角色匹配
    if (!isRoleMatch(loginForm.value.userType, serverRole)) {
      errorMsg.value = '用户类型不匹配，请选择正确的用户类型';
      return;
    }
    ElMessage.success('登录成功')
    errorMsg.value = ''
    const userInfo = {
      username: loginForm.value.username,
      real_name: res.data.real_name || loginForm.value.username,
      role: serverRole,
      // 如果需要，可以保留userType字段
      userType: loginForm.value.userType
    }
    localStorage.setItem('currentUser', JSON.stringify(userInfo))
    localStorage.setItem('username', loginForm.value.username); // 明确存储用户名
    if (rememberPassword.value) {
      localStorage.setItem('rememberedPassword', loginForm.value.password);
    } else {
      localStorage.removeItem('rememberedPassword');
    }
    // 根据角色类型跳转到不同页面
    switch(serverRole) {
      case 'RESEARCHER':
        await router.push('/user');
        break;
      case 'ADMIN':
        await router.push('/user');
        break;
      case 'LAB_TECHNICIAN':
        await router.push('/user');
        break;
      case 'APPROVER':
         router.push('/rd');
        break;
      case 'SUPERVISOR':
        await router.push('/user');
        break;
      default:
        await router.push('/user');
    }
  } catch (err) {
    errorMsg.value = '用户名或密码错误'
  }
}
// 验证前端选择的userType是否与服务器返回的role匹配
const isRoleMatch = (selectedUserType, serverRole) => {
  // 这里可以根据实际业务逻辑调整匹配规则
  // 简单情况下可以直接比较（如果前后端枚举值一致）
  return selectedUserType === serverRole;

  // 或者更复杂的匹配逻辑，例如：
  // const roleMapping = {
  //   'RESEARCHER': ['RESEARCHER', 'SENIOR_RESEARCHER'],
  //   'ADMIN': ['ADMIN', 'SUPER_ADMIN'],
  //   // 其他映射关系
  // };
  // return roleMapping[selectedUserType]?.includes(serverRole);
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
