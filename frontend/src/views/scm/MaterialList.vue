<template>
  <div class="material-list">
    <el-card>
      <div class="header">
        <span>物料管理</span>
        <el-button type="primary" @click="showAddDialog = true">新增物料</el-button>
      </div>
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="物料名称">
          <el-input v-model="searchForm.materialName" placeholder="请输入物料名称" />
        </el-form-item>
        <el-form-item label="物料编号">
          <el-input v-model="searchForm.materialCode" placeholder="请输入物料编号" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="fetchList">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="materialList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="materialCode" label="物料编号" width="120" />
        <el-table-column prop="materialName" label="物料名称" width="150" />
        <el-table-column prop="materialType" label="物料类型" width="100" />
        <el-table-column prop="category" label="物料分类" width="100" />
        <el-table-column prop="specification" label="规格" width="120" />
        <el-table-column prop="unit" label="单位" width="80" />
        <el-table-column prop="unitPrice" label="单价" width="100" />
        <el-table-column prop="currency" label="货币" width="80" />
        <el-table-column prop="currentStock" label="当前库存" width="100" />
        <el-table-column prop="minStock" label="最小库存" width="100" />
        <el-table-column prop="maxStock" label="最大库存" width="100" />
        <el-table-column prop="location" label="库位" width="100" />
        <el-table-column prop="materialStatus" label="物料状态" width="100" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button size="small" @click="editMaterial(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteMaterial(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 新增/编辑弹窗 -->
    <el-dialog v-model="showAddDialog" :title="editMode ? '编辑物料' : '新增物料'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="物料编号">
          <el-input v-model="form.materialCode" />
        </el-form-item>
        <el-form-item label="物料名称">
          <el-input v-model="form.materialName" />
        </el-form-item>
        <el-form-item label="物料类型">
          <el-input v-model="form.materialType" />
        </el-form-item>
        <el-form-item label="物料分类">
          <el-input v-model="form.category" />
        </el-form-item>
        <el-form-item label="规格">
          <el-input v-model="form.specification" />
        </el-form-item>
        <el-form-item label="单位">
          <el-input v-model="form.unit" />
        </el-form-item>
        <el-form-item label="单价">
          <el-input v-model="form.unitPrice" type="number" />
        </el-form-item>
        <el-form-item label="货币">
          <el-input v-model="form.currency" />
        </el-form-item>
        <el-form-item label="当前库存">
          <el-input v-model="form.currentStock" type="number" />
        </el-form-item>
        <el-form-item label="最小库存">
          <el-input v-model="form.minStock" type="number" />
        </el-form-item>
        <el-form-item label="最大库存">
          <el-input v-model="form.maxStock" type="number" />
        </el-form-item>
        <el-form-item label="库位">
          <el-input v-model="form.location" />
        </el-form-item>
        <el-form-item label="物料状态">
          <el-input v-model="form.status" />
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

const materialList = ref([])
const showAddDialog = ref(false)
const editMode = ref(false)
const form = reactive({})
const searchForm = reactive({ materialName: '', materialCode: '' })

const fetchList = async () => {
  const { data } = await axios.get('/api/material/list')
  materialList.value = data.data || []
}

const resetSearch = () => {
  searchForm.materialName = ''
  searchForm.materialCode = ''
  fetchList()
}

const editMaterial = (row) => {
  Object.assign(form, row)
  editMode.value = true
  showAddDialog.value = true
}

const deleteMaterial = (id) => {
  ElMessageBox.confirm('确定要删除该物料吗？', '提示', { type: 'warning' })
    .then(async () => {
      await axios.delete(`/api/material/delete/${id}`)
      ElMessage.success('删除成功')
      fetchList()
    })
}

const submitForm = async () => {
  if (editMode.value) {
    await axios.post('/api/material/update', form)
    ElMessage.success('更新成功')
  } else {
    await axios.post('/api/material/add', form)
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
.material-list .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.search-form {
  margin-bottom: 12px;
}
</style> 