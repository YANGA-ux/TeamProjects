<template>
  <div class="experiment-list">
    <el-card>
      <div class="header">
        <span>实验管理</span>
        <el-button type="primary" @click="showAddDialog = true">新增实验</el-button>
      </div>
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="实验名称">
          <el-input v-model="searchForm.experimentName" placeholder="请输入实验名称" />
        </el-form-item>
        <el-form-item label="实验编号">
          <el-input v-model="searchForm.experimentCode" placeholder="请输入实验编号" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="fetchList">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="experimentList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="experimentCode" label="实验编号" width="120" />
        <el-table-column prop="experimentName" label="实验名称" width="150" />
        <el-table-column prop="experimentType" label="实验类型" width="100" />
        <el-table-column prop="experimentStatus" label="实验状态" width="100" />
        <el-table-column prop="description" label="实验描述" width="200" />
        <el-table-column prop="objective" label="实验目标" width="150" />
        <el-table-column prop="methodology" label="实验方法" width="150" />
        <el-table-column prop="plannedStartTime" label="计划开始时间" width="150" />
        <el-table-column prop="plannedEndTime" label="计划结束时间" width="150" />
        <el-table-column prop="actualStartTime" label="实际开始时间" width="150" />
        <el-table-column prop="actualEndTime" label="实际结束时间" width="150" />
        <el-table-column prop="projectId" label="关联项目ID" width="100" />
        <el-table-column prop="responsibleUserId" label="负责人ID" width="100" />
        <el-table-column prop="result" label="实验结果" width="150" />
        <el-table-column prop="conclusion" label="实验结论" width="150" />
        <el-table-column prop="attachments" label="附件路径" width="150" />
        <el-table-column prop="status" label="数据状态" width="100" />
        <el-table-column prop="createTime" label="创建时间" width="150" />
        <el-table-column prop="updateTime" label="更新时间" width="150" />
        <el-table-column prop="createBy" label="创建人" width="100" />
        <el-table-column prop="updateBy" label="更新人" width="100" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button size="small" @click="editExperiment(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteExperiment(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 新增/编辑弹窗 -->
    <el-dialog v-model="showAddDialog" :title="editMode ? '编辑实验' : '新增实验'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="实验编号">
          <el-input v-model="form.experimentCode" />
        </el-form-item>
        <el-form-item label="实验名称">
          <el-input v-model="form.experimentName" />
        </el-form-item>
        <el-form-item label="实验类型">
          <el-input v-model="form.experimentType" />
        </el-form-item>
        <el-form-item label="实验状态">
          <el-input v-model="form.experimentStatus" />
        </el-form-item>
        <el-form-item label="实验描述">
          <el-input v-model="form.description" type="textarea" />
        </el-form-item>
        <el-form-item label="实验目标">
          <el-input v-model="form.objective" />
        </el-form-item>
        <el-form-item label="实验方法">
          <el-input v-model="form.methodology" />
        </el-form-item>
        <el-form-item label="计划开始时间">
          <el-date-picker v-model="form.plannedStartTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="计划结束时间">
          <el-date-picker v-model="form.plannedEndTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="实际开始时间">
          <el-date-picker v-model="form.actualStartTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="实际结束时间">
          <el-date-picker v-model="form.actualEndTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="关联项目ID">
          <el-input v-model="form.projectId" type="number" />
        </el-form-item>
        <el-form-item label="负责人ID">
          <el-input v-model="form.responsibleUserId" type="number" />
        </el-form-item>
        <el-form-item label="实验结果">
          <el-input v-model="form.result" type="textarea" />
        </el-form-item>
        <el-form-item label="实验结论">
          <el-input v-model="form.conclusion" type="textarea" />
        </el-form-item>
        <el-form-item label="附件路径">
          <el-input v-model="form.attachments" />
        </el-form-item>
        <el-form-item label="数据状态">
          <el-input v-model="form.status" type="number" />
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker v-model="form.createTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="更新时间">
          <el-date-picker v-model="form.updateTime" type="datetime" placeholder="选择时间" />
        </el-form-item>
        <el-form-item label="创建人">
          <el-input v-model="form.createBy" />
        </el-form-item>
        <el-form-item label="更新人">
          <el-input v-model="form.updateBy" />
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

const experimentList = ref([])
const showAddDialog = ref(false)
const editMode = ref(false)
const form = reactive({})
const searchForm = reactive({ experimentName: '', experimentCode: '' })

const fetchList = async () => {
  const { data } = await axios.get('/api/experiment/list')
  experimentList.value = data.data || []
}

const resetSearch = () => {
  searchForm.experimentName = ''
  searchForm.experimentCode = ''
  fetchList()
}

const editExperiment = (row) => {
  Object.assign(form, row)
  editMode.value = true
  showAddDialog.value = true
}

const deleteExperiment = (id) => {
  ElMessageBox.confirm('确定要删除该实验吗？', '提示', { type: 'warning' })
    .then(async () => {
      await axios.delete(`/api/experiment/delete/${id}`)
      ElMessage.success('删除成功')
      fetchList()
    })
}

const submitForm = async () => {
  if (editMode.value) {
    await axios.post('/api/experiment/update', form)
    ElMessage.success('更新成功')
  } else {
    await axios.post('/api/experiment/add', form)
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
.experiment-list .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.search-form {
  margin-bottom: 12px;
}
</style>
