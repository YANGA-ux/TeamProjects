<template>
  <div>
    <h2>生产监控</h2>
    <el-table :data="batchList" style="width: 100%" v-loading="loading">
      <el-table-column prop="batchCode" label="批次编号" width="120" />
      <el-table-column prop="productName" label="产品名称" width="120" />
      <el-table-column prop="batchStatus" label="生产状态" width="120">
        <template #default="{ row }">
          <el-tag :type="statusTagType(row.batchStatus)">
            {{ statusText(row.batchStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="plannedQuantity" label="计划数量" width="100" />
      <el-table-column prop="actualQuantity" label="实际数量" width="100" />
      <el-table-column prop="productionLine" label="生产线" width="100" />
      <el-table-column prop="equipment" label="设备" width="100" />
      <el-table-column label="操作" width="220">
        <template #default="{ row }">
          <el-button type="primary" size="small" @click="showStandard(row)">
            查看质量标准
          </el-button>
          <el-button
              v-if="row.batchStatus === 'QUALITY_CHECK'"
              type="success"
              size="small"
              @click="handleQcResult(row, true)"
          >通过</el-button>
          <el-button
              v-if="row.batchStatus === 'QUALITY_CHECK'"
              type="danger"
              size="small"
              @click="handleQcResult(row, false)"
          >不通过</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 质量标准弹窗 -->
    <el-dialog v-model="standardVisible" title="质量标准详情" width="600px">
      <el-descriptions :column="2" v-if="currentStandard">
        <el-descriptions-item label="标准编号">{{ currentStandard.standardCode }}</el-descriptions-item>
        <el-descriptions-item label="标准名称">{{ currentStandard.standardName }}</el-descriptions-item>
        <el-descriptions-item label="标准状态">{{ currentStandard.standardStatus }}</el-descriptions-item>
        <el-descriptions-item label="生效日期">{{ currentStandard.effectiveDate }}</el-descriptions-item>
        <el-descriptions-item label="失效日期">{{ currentStandard.expiryDate }}</el-descriptions-item>
        <el-descriptions-item label="描述">{{ currentStandard.description }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <el-button @click="standardVisible = false">关闭</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'

const batchList = ref([])
const loading = ref(false)
const standardVisible = ref(false)
const currentStandard = ref(null)

function statusText(status) {
  switch (status) {
    case 'PLANNING': return '计划中'
    case 'QUALITY_CHECK': return '质检中'
    case 'COMPLETED': return '已完成'
    case 'REJECTED': return '不合格'
    default: return status
  }
}
function statusTagType(status) {
  switch (status) {
    case 'PLANNING': return ''
    case 'QUALITY_CHECK': return 'warning'
    case 'COMPLETED': return 'success'
    case 'REJECTED': return 'danger'
    default: return ''
  }
}

// 获取批次列表（带质量标准信息）
async function fetchBatchList() {
  loading.value = true
  try {
    // 假设后端DTO返回批次+质量标准部分字段
    const res = await axios.get('/api/production-monitoring/list')
    batchList.value = res.data.data || []
  } catch (e) {
    ElMessage.error('获取生产批次失败')
  } finally {
    loading.value = false
  }
}

// 查看质量标准
async function showStandard(row) {
  try {
    // 也可以直接用 row.qualityStandard，如果后端DTO已带全
    const res = await axios.get(`/api/production-monitoring/quality-standard/by-product/${row.productCode}`)
    currentStandard.value = res.data.data
    standardVisible.value = true
  } catch (e) {
    ElMessage.error('获取质量标准失败')
  }
}

// 质检通过/不通过
function handleQcResult(row, isPass) {
  ElMessageBox.confirm(
      `确定将批次【${row.batchCode}】标记为${isPass ? '通过' : '不通过'}吗？`,
      '质检确认',
      { type: isPass ? 'success' : 'warning' }
  ).then(async () => {
    try {
      await axios.post('/api/production-monitoring/qc-result', {
        batchCode: row.batchCode,
        result: isPass ? 'PASSED' : 'REJECTED'
      })
      ElMessage.success('操作成功')
      fetchBatchList()
    } catch (e) {
      ElMessage.error('操作失败')
    }
  })
}

onMounted(fetchBatchList)
</script>