<template>
  <div class="batch-list">
    <div class="page-header">
      <h2>生产批次管理</h2>
      <el-button type="primary" @click="showAddDialog = true">
        <el-icon><Plus /></el-icon>
        新增批次
      </el-button>
    </div>
    <el-table :data="batchList" v-loading="loading" stripe style="width: 100%; margin-top: 20px;">
      <el-table-column prop="batchCode" label="批次编号" width="120" />
      <el-table-column prop="productCode" label="产品编号" width="120" />
      <el-table-column prop="productName" label="产品名称" width="150" />
      <el-table-column prop="batchStatus" label="批次状态" width="100" />
      <el-table-column prop="plannedQuantity" label="计划数量" width="100" />
      <el-table-column prop="actualQuantity" label="实际数量" width="100" />
      <el-table-column prop="unit" label="单位" width="80" />
      <el-table-column prop="plannedStart_time" label="计划开始" width="160" />
      <el-table-column prop="plannedEndTime" label="计划结束" width="160" />
      <el-table-column prop="actualStarTime" label="实际开始" width="160" />
      <el-table-column prop="actualEndTime" label="实际结束" width="160" />
      <el-table-column prop="productionLine" label="生产线" width="100" />
      <el-table-column prop="equipment" label="设备" width="100" />
      <el-table-column prop="processParameters" label="工艺参数" width="120" />
      <el-table-column prop="qualityParameters" label="质量参数" width="120" />
      <el-table-column prop="deviationRecords" label="偏差记录" width="120" />
      <el-table-column prop="attachments" label="附件" width="100" />
      <el-table-column prop="notes" label="备注" width="100" />
      <el-table-column prop="status" label="状态" width="80" />
      <el-table-column prop="createTime" label="创建时间" width="160" />
      <el-table-column prop="createTime" label="创建时间" width="160" />
      <el-table-column prop="updateTime" label="更新时间" width="160" />
      <el-table-column prop="createBy" label="创建人" width="100" />
      <el-table-column prop="updateBy" label="更新人" width="100" />
      <el-table-column prop="batchNumber" label="批号" width="120" />
      <el-table-column prop="drugId" label="药品ID" width="80" />
      <el-table-column label="操作" width="180" fixed="right">
        <template #default="{ row }">
          <el-button size="small" @click="showEdit(row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px" @close="resetForm">
      <el-form :model="form" ref="formRef" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="批次编号" prop="batchCode">
              <el-input v-model="form.batchCode" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="产品编号" prop="productCode">
              <el-input v-model="form.productCode" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="产品名称" prop="productName">
              <el-input v-model="form.productName" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="批次状态" >
              <el-input v-model="form.status" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="计划数量" prop="plannedQuantity">
              <el-input v-model="form.plannedQuantity" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实际数量" prop="actualQuantity">
              <el-input v-model="form.actualQuantity" type="number" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="单位" prop="unit">
              <el-input v-model="form.unit" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="生产线" prop="productionLine">
              <el-input v-model="form.productionLine" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="设备" prop="equipment">
              <el-input v-model="form.equipment" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="工艺参数" prop="processParameters">
              <el-input v-model="form.processParameters" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="质量参数" prop="qualityParameters">
              <el-input v-model="form.qualityParameters" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="偏差记录" prop="deviationRecords">
              <el-input v-model="form.deviationRecords" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="附件" prop="attachments">
          <el-input v-model="form.attachments" />
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="form.notes" />
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-input v-model="form.status" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="药品ID" prop="drugId">
              <el-input v-model="form.drugId" type="number" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="批号" prop="batchNumber">
              <el-input v-model="form.batchNumber" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="showAddDialog" :title="dialogTitle" width="600px" @close="resetForm">
      <el-form :model="form" ref="formRef" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="批次编号" prop="batchCode">
              <el-input v-model="form.batchCode" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="产品编号" prop="productCode">
              <el-input v-model="form.productCode" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="产品名称" prop="productName">
              <el-input v-model="form.productName" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="批次状态" >
              <el-input v-model="form.status" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="计划数量" prop="plannedQuantity">
              <el-input v-model="form.plannedQuantity" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实际数量" prop="actualQuantity">
              <el-input v-model="form.actualQuantity" type="number" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="单位" prop="unit">
              <el-input v-model="form.unit" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="生产线" prop="productionLine">
              <el-input v-model="form.productionLine" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="设备" prop="equipment">
              <el-input v-model="form.equipment" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="工艺参数" prop="processParameters">
              <el-input v-model="form.processParameters" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="质量参数" prop="qualityParameters">
              <el-input v-model="form.qualityParameters" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="偏差记录" prop="deviationRecords">
              <el-input v-model="form.deviationRecords" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="附件" prop="attachments">
          <el-input v-model="form.attachments" />
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="form.notes" />
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-input v-model="form.status" type="number" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="药品ID" prop="drugId">
              <el-input v-model="form.drugId" type="number" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="批号" prop="batchNumber">
              <el-input v-model="form.batchNumber" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>




  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import axios from 'axios'

const batchList = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const dialogTitle = ref('')
const showAddDialog = ref(false)
const formRef = ref(null)
const form = reactive({
    id: null,
    batchCode: '',
    productCode: '',
    productName: '',
    batchStatus: '',
    plannedQuantity: null,
    actualQuantity: null,
    unit: '',
    plannedStartTime: '',
    plannedEndTime: '',
    actualStartTime: '',
    actualEndTime: '',
    productionLine: '',
    equipment: '',
    processParameters: '',
    qualityParameters: '',
    deviationRecords: '',
    attachments: '',
    notes: '',
    status: null,
    createTime: '',
    updateTime: '',
    createBy: '',
    updateBy: '',
    batchNumber: '',
    drugId: null
})

const getBatchList = async () => {
  loading.value = true
  try {
    const res = await axios.get('/api/prod/batch/list')
    if (res.data.code === 200) {
      batchList.value = res.data.data
    } else {
      ElMessage.error(res.data.message || '获取批次列表失败')
    }
  } catch (e) {
    ElMessage.error('获取批次列表失败')
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  Object.assign(form, {
    id: null,
    batchCode: '',
    productCode: '',
    productName: '',
    batchStatus: '',
    plannedQuantity: null,
    actualQuantity: null,
    unit: '',
    plannedStartTime: '',
    plannedEndTime: '',
    actualStartTime: '',
    actualEndTime: '',
    productionLine: '',
    equipment: '',
    processParameters: '',
    qualityParameters: '',
    deviationRecords: '',
    attachments: '',
    notes: '',
    status: null,
    createTime: '',
    updateTime: '',
    createBy: '',
    updateBy: '',
    batchNumber: '',
    drugId: null
  })
}

const showEdit = (row) => {
  dialogTitle.value = '编辑批次'
  dialogVisible.value = true
  Object.assign(form, row)
}

const handleDelete = async (row) => {
  try {
    await axios.delete(`/api/prod/batch/delete/${row.id}`)
    ElMessage.success('删除成功')
    getBatchList()
  } catch (e) {
    ElMessage.error('删除失败')
  }
}

const handleSubmit = async () => {
  try {
    if (form.id) {
      // 编辑
      await axios.put('/api/prod/batch/update', form)
      ElMessage.success('更新成功')
    } else {
      // 新增
      await axios.post('/api/prod/batch/add', form)
      ElMessage.success('添加成功')
    }
    dialogVisible.value = false
    getBatchList()
  } catch (e) {
    ElMessage.error('操作失败')
  }
}

onMounted(() => {
  getBatchList()
})
</script>

<style scoped>
.batch-list {
  padding: 24px;
}
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}
</style> 