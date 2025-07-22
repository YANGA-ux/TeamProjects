<template>
  <div class="supplier-list">
    <el-card>
      <div class="header">
        <span>供应商管理</span>
        <el-button type="primary" @click="showAddDialog = true">新增供应商</el-button>
      </div>
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="供应商名称">
          <el-input v-model="searchForm.supplierName" placeholder="请输入供应商名称" />
        </el-form-item>
        <el-form-item label="供应商编号">
          <el-input v-model="searchForm.supplierCode" placeholder="请输入供应商编号" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="fetchList">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="supplierList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="supplierCode" label="供应商编号" width="120" />
        <el-table-column prop="supplierName" label="供应商名称" width="150" />
        <el-table-column prop="supplierType" label="类型" width="100" />
        <el-table-column prop="contactPerson" label="联系人" width="100" />
        <el-table-column prop="contactPhone" label="联系电话" width="120" />
        <el-table-column prop="contactEmail" label="邮箱" width="150" />
        <el-table-column prop="address" label="地址" width="200" />
        <el-table-column prop="supplierStatus" label="状态" width="100" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button size="small" @click="editSupplier(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteSupplier(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 新增/编辑弹窗 -->
    <el-dialog v-model="showAddDialog" :title="editMode ? '编辑供应商' : '新增供应商'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="供应商编号">
          <el-input v-model="form.supplierCode" />
        </el-form-item>
        <el-form-item label="供应商名称">
          <el-input v-model="form.supplierName" />
        </el-form-item>
        <el-form-item label="类型">
          <el-input v-model="form.supplierType" />
        </el-form-item>
        <el-form-item label="联系人">
          <el-input v-model="form.contactPerson" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="form.contactPhone" />
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.contactEmail" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" />
        </el-form-item>
        <el-form-item label="stats">
          <el-input v-model="form.status"/>
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="form.supplierStatus" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.notes" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showAddDialog = false">取消</el-button>
        <el-button type="primary" @click="submitForm">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'

const supplierList = ref([])
const showAddDialog = ref(false)
const editMode = ref(false)
const form = reactive({})
const searchForm = reactive({ supplierName: '', supplierCode: '' })

const fetchList = async () => {
  const { data } = await axios.get('/api/supplier/list')
  supplierList.value = data.data || []
}

const resetSearch = () => {
  searchForm.supplierName = ''
  searchForm.supplierCode = ''
  fetchList()
}

const editSupplier = (row) => {
  Object.assign(form, row)
  editMode.value = true
  showAddDialog.value = true
}

const deleteSupplier = (id) => {
  ElMessageBox.confirm('确定要删除该供应商吗？', '提示', { type: 'warning' })
    .then(async () => {
      await axios.delete(`/api/supplier/delete/${id}`)
      ElMessage.success('删除成功')
      fetchList()
    })
}

const submitForm = async () => {
  if (editMode.value) {
    await axios.post('/api/supplier/update', form)
    ElMessage.success('更新成功')
  } else {
    await axios.post('/api/supplier/add', form)
    ElMessage.success('新增成功')
  }
  showAddDialog.value = false
  fetchList()
  editMode.value = false
  Object.keys(form).forEach(k => form[k] = '')
}

onMounted(() => {
  fetchList()
})
</script>

<style scoped>
.supplier-list .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.search-form {
  margin-bottom: 12px;
}
</style> 