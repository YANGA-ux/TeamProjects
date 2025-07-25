<template>
  <div class="profile-container">
    <h2>个人资料</h2>
    <div class="profile-content">
      <el-form :model="userForm" label-width="100px">
        <el-form-item label="用户ID">
          <el-input v-model="userForm.id" disabled />
        </el-form-item>
        <el-form-item label="用户名">
          <el-input v-model="userForm.username" disabled />
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input v-model="userForm.real_name" :disabled="!isEditing" />
        </el-form-item>
        <el-form-item label="角色">
          <el-input v-model="userForm.role" disabled />
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="userForm.status" disabled />
        </el-form-item>
        <div class="form-actions">
          <el-button
              v-if="!isEditing"
              type="primary"
              @click="isEditing = true"
          >
            编辑资料
          </el-button>

          <template v-else>
            <el-button type="success" @click="saveProfile">保存</el-button>
            <el-button @click="cancelEdit">取消</el-button>
          </template>
        </div>
      </el-form>

      <el-divider />

      <div class="password-section">
        <h3>修改密码</h3>
        <el-form :model="passwordForm" label-width="100px">
          <el-form-item label="原密码">
            <el-input
                v-model="passwordForm.oldPassword"
                type="password"
                show-password
                placeholder="请输入原密码"
            />
          </el-form-item>

          <el-form-item label="新密码">
            <el-input
                v-model="passwordForm.newPassword"
                type="password"
                show-password
                placeholder="请输入新密码"
            />
          </el-form-item>

          <el-form-item label="确认密码">
            <el-input
                v-model="passwordForm.confirmPassword"
                type="password"
                show-password
                placeholder="请再次输入新密码"
            />
          </el-form-item>

          <el-button type="primary" @click="changePassword">修改密码</el-button>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080/api/user';

// 用户表单数据
const userForm = ref({
  id: null,
  username: '',
  real_name: '',
  role: '',
  status: ''
});

// 密码表单数据
const passwordForm = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
});

const isEditing = ref(false);
const originalUserData = ref({});

// 获取当前用户信息
const fetchUserProfile = async () => {
  try {
    // 从本地存储获取当前用户名
    const username = localStorage.getItem('username');
    console.log('当前用户名:', username); // 调试用

    if (!username) {
      ElMessage.error('未获取到用户信息，请重新登录');
      return;
    }

    const response = await axios.get(`${API_BASE_URL}/info`, {
      params: { username }
    });

    console.log('用户信息响应:', response.data); // 调试用

    if (response.data.code === 200) {
      userForm.value = response.data.data;
      originalUserData.value = { ...userForm.value };
    } else {
      ElMessage.error(response.data.message || '获取用户信息失败');
    }
  } catch (error) {
    console.error('获取用户信息错误:', error); // 调试用
    ElMessage.error('获取用户信息失败: ' + error.message);
  }
};

// 保存个人资料
const saveProfile = async () => {
  try {
    const response = await axios.put(`${API_BASE_URL}/${userForm.value.id}`, {
      real_name: userForm.value.real_name,
      // 其他可更新字段可以在这里添加
    });

    if (response.data.code === 200) {
      ElMessage.success('个人资料更新成功');
      isEditing.value = false;
      await fetchUserProfile(); // 刷新数据
    } else {
      ElMessage.error(response.data.message || '更新失败');
    }
  } catch (error) {
    ElMessage.error('更新失败: ' + (error.response?.data?.message || error.message));
  }
};

// 取消编辑
const cancelEdit = () => {
  userForm.value = { ...originalUserData.value };
  isEditing.value = false;
};

// 修改密码
const changePassword = async () => {
  if (passwordForm.value.newPassword !== passwordForm.value.confirmPassword) {
    ElMessage.error('两次输入的新密码不一致');
    return;
  }

  try {
    const username = localStorage.getItem('username');
    const response = await axios.post(`${API_BASE_URL}/change-password`, null, {
      params: {
        username,
        oldPassword: passwordForm.value.oldPassword,
        newPassword: passwordForm.value.newPassword
      }
    });

    if (response.data.code === 200) {
      ElMessage.success('密码修改成功');
      passwordForm.value = {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      };
    } else {
      ElMessage.error(response.data.message || '密码修改失败');
    }
  } catch (error) {
    ElMessage.error('密码修改失败: ' + (error.response?.data?.message || error.message));
  }
};
// 初始化加载
onMounted(() => {
  fetchUserProfile();
});
</script>

<style scoped>
.profile-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}
.profile-content {
  background: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.form-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
.password-section {
  margin-top: 30px;
}

.el-divider {
  margin: 20px 0;
}

h2, h3 {
  color: #303133;
  margin-bottom: 20px;
}
.el-form-item {
  margin-bottom: 22px;
}
</style>