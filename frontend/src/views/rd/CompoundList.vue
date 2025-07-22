<template>
  <div class="compound-list">
    <!-- 顶部导航栏 -->
    <el-header class="header">
      <div class="header-content">
        <div class="logo">
          <h2>生物医药企业管理系统 - 化合物管理</h2>
        </div>
        <div class="user-info">
          <el-dropdown>
            <span class="user-dropdown">
              <el-avatar :size="32" icon="UserFilled" />
              <span style="margin-left: 8px">{{ userInfo.real_name || userInfo.username }}</span>
              <span style="margin-left: 8px; color: #666;">({{ userInfo.role }})</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="goBack">返回主页</el-dropdown-item>
                <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </el-header>

    <!-- 主要内容区域 -->
    <el-main class="main-content">
      <!-- 搜索和操作栏 -->
      <div class="toolbar">
        <el-row :gutter="20">
          <el-col :span="8">
            <el-input
              v-model="searchKeyword"
              placeholder="搜索化合物名称或编号"
              clearable
              @input="handleSearch"
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-select v-model="searchCategory" placeholder="选择类别" clearable @change="handleSearch">
              <el-option label="非甾体抗炎药" value="非甾体抗炎药" />
              <el-option label="解热镇痛药" value="解热镇痛药" />
              <el-option label="抗生素" value="抗生素" />
            </el-select>
          </el-col>
          <el-col :span="12" style="text-align: right">
            <el-button type="primary" @click="showAddDialog">
              <el-icon><Plus /></el-icon>
              新增化合物
            </el-button>
            <el-button @click="refreshData">
              <el-icon><Refresh /></el-icon>
              刷新
            </el-button>
          </el-col>
        </el-row>
      </div>

      <!-- 数据表格 -->
      <el-table :data="filteredCompounds" style="width: 100%" v-loading="loading">
        <el-table-column prop="compoundCode" label="化合物编号" width="120" />
        <el-table-column prop="compoundName" label="化合物名称" width="150" />
        <el-table-column prop="chemicalFormula" label="化学分子式" width="120" />
        <el-table-column prop="molecularWeight" label="分子量" width="100" />
        <el-table-column prop="casNumber" label="CAS号" width="120" />
        <el-table-column prop="category" label="类别" width="120" />
        <el-table-column prop="description" label="描述" show-overflow-tooltip />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="showEditDialog(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-main>

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="60%"
      @close="resetForm"
    >
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="化合物编号" prop="compoundCode">
              <el-input v-model="form.compoundCode" placeholder="请输入化合物编号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="化合物名称" prop="compoundName">
              <el-input v-model="form.compoundName" placeholder="请输入化合物名称" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="化学分子式" prop="chemicalFormula">
              <el-input v-model="form.chemicalFormula" placeholder="请输入化学分子式" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="分子量" prop="molecularWeight">
              <el-input-number v-model="form.molecularWeight" :precision="4" :step="0.1" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="CAS号" prop="casNumber">
              <el-input v-model="form.casNumber" placeholder="请输入CAS号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类别" prop="category">
              <el-select v-model="form.category" placeholder="请选择类别">
                <el-option label="非甾体抗炎药" value="非甾体抗炎药" />
                <el-option label="解热镇痛药" value="解热镇痛药" />
                <el-option label="抗生素" value="抗生素" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            :rows="3"
            placeholder="请输入描述"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Plus, Refresh } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()

// 响应式数据
const userInfo = ref({})
const compounds = ref([])
const loading = ref(false)
const searchKeyword = ref('')
const searchCategory = ref('')
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const dialogTitle = ref('新增化合物')
const isEdit = ref(false)
const formRef = ref()

// 表单数据
const form = reactive({
  id: null,
  compoundCode: '',
  compoundName: '',
  chemicalFormula: '',
  molecularWeight: null,
  casNumber: '',
  category: '',
  description: ''
})

// 表单验证规则
const rules = {
  compoundCode: [{ required: true, message: '请输入化合物编号', trigger: 'blur' }],
  compoundName: [{ required: true, message: '请输入化合物名称', trigger: 'blur' }],
  chemicalFormula: [{ required: true, message: '请输入化学分子式', trigger: 'blur' }],
  category: [{ required: true, message: '请选择类别', trigger: 'change' }]
}

// 计算属性
const filteredCompounds = computed(() => {
  let result = compounds.value
  
  if (searchKeyword.value) {
    result = result.filter(item => 
      item.compoundName.includes(searchKeyword.value) ||
      item.compoundCode.includes(searchKeyword.value)
    )
  }
  
  if (searchCategory.value) {
    result = result.filter(item => item.category === searchCategory.value)
  }
  
  return result
})

// 获取用户信息
const getUserInfo = async () => {
  try {
    const currentUser = localStorage.getItem('currentUser')
    if (currentUser) {
      const user = JSON.parse(currentUser)
      const res = await axios.get(`http://localhost:8080/api/user/info?username=${user.username}`)
      if (res.data.code === 200) {
        userInfo.value = res.data.data
      }
    }
  } catch (error) {
    console.error('获取用户信息失败:', error)
  }
}

// 获取化合物列表
const getCompounds = async () => {
  loading.value = true
  try {
    const res = await axios.get('http://localhost:8080/api/compounds')
    if (res.data.code === 200) {
      compounds.value = res.data.data
      total.value = compounds.value.length
    }
  } catch (error) {
    console.error('获取化合物列表失败:', error)
    ElMessage.error('获取化合物列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1
}

// 刷新数据
const refreshData = () => {
  getCompounds()
}

// 显示新增对话框
const showAddDialog = () => {
  isEdit.value = false
  dialogTitle.value = '新增化合物'
  dialogVisible.value = true
}

// 显示编辑对话框
const showEditDialog = (row) => {
  isEdit.value = true
  dialogTitle.value = '编辑化合物'
  Object.assign(form, row)
  dialogVisible.value = true
}

// 提交表单
const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    
    if (isEdit.value) {
      // 编辑
      const res = await axios.put(`http://localhost:8080/api/compounds/${form.id}`, form)
      if (res.data.code === 200) {
        ElMessage.success('编辑成功')
        dialogVisible.value = false
        getCompounds()
      }
    } else {
      // 新增
      const res = await axios.post('http://localhost:8080/api/compounds', form)
      if (res.data.code === 200) {
        ElMessage.success('新增成功')
        dialogVisible.value = false
        getCompounds()
      }
    }
  } catch (error) {
    console.error('提交失败:', error)
    ElMessage.error('操作失败')
  }
}

// 删除处理
const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm('确定要删除这个化合物吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    const res = await axios.delete(`http://localhost:8080/api/compounds/${row.id}`)
    if (res.data.code === 200) {
      ElMessage.success('删除成功')
      getCompounds()
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除失败:', error)
      ElMessage.error('删除失败')
    }
  }
}

// 分页处理
const handleSizeChange = (val) => {
  pageSize.value = val
  currentPage.value = 1
}

const handleCurrentChange = (val) => {
  currentPage.value = val
}

// 重置表单
const resetForm = () => {
  Object.assign(form, {
    id: null,
    compoundCode: '',
    compoundName: '',
    chemicalFormula: '',
    molecularWeight: null,
    casNumber: '',
    category: '',
    description: ''
  })
  formRef.value?.resetFields()
}

// 返回主页
const goBack = () => {
  router.push('/user')
}

// 退出登录
const logout = () => {
  localStorage.removeItem('currentUser')
  ElMessage.success('退出登录成功')
  router.push('/login')
}

onMounted(() => {
  getUserInfo()
  getCompounds()
})
</script>

<style scoped>
.compound-list {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.header {
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  height: 100%;
}

.logo h2 {
  color: #409EFF;
  margin: 0;
}

.user-dropdown {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.main-content {
  margin-top: 60px;
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
  padding: 20px;
}

.toolbar {
  background-color: #fff;
  padding: 20px;
  margin-bottom: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style> 