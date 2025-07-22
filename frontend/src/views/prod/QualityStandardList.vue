<template>
  <div class="quality-standard-list">
    <div class="page-header">
      <h2>质量标准管理</h2>
      <el-button type="primary" @click="showAddDialog">
        <el-icon><Plus /></el-icon>
        新增标准
      </el-button>
    </div>

    <!-- 搜索和筛选 -->
    <el-card class="search-card">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input
            v-model="searchForm.standardCode"
            placeholder="标准编号"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-col>
        <el-col :span="6">
          <el-input
            v-model="searchForm.standardName"
            placeholder="标准名称"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-col>
        <el-col :span="6">
          <el-select v-model="searchForm.status" placeholder="状态" clearable>
            <el-option label="生效" value="active" />
            <el-option label="失效" value="inactive" />
            <el-option label="草稿" value="draft" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-col>
      </el-row>
    </el-card>

    <!-- 统计数据 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-number">{{ stats.total || 0 }}</div>
          <div class="stat-label">总标准</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-number">{{ stats.active || 0 }}</div>
          <div class="stat-label">生效标准</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-number">{{ stats.inactive || 0 }}</div>
          <div class="stat-label">失效标准</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-number">{{ stats.draft || 0 }}</div>
          <div class="stat-label">草稿标准</div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 标准列表 -->
    <el-card>
      <el-table :data="standardList" v-loading="loading" stripe>
        <el-table-column prop="standardCode" label="标准编号" width="120" />
        <el-table-column prop="standardName" label="标准名称" width="200" />
        <el-table-column prop="drugName" label="适用药品" width="150">
          <template #default="{ row }">
            <span v-if="row.drugName">{{ row.drugName }}</span>
            <span v-else class="text-muted">通用标准</span>
          </template>
        </el-table-column>
        <el-table-column prop="standardCode" label="标准编号" width="120" />
        <el-table-column prop="standardName" label="标准名称" width="200" />
        <el-table-column prop="productCode" label="产品编号" width="120" />
        <el-table-column prop="productName" label="产品名称" width="150" />
        <el-table-column prop="standardType" label="标准类型" width="120" />
        <el-table-column prop="version" label="版本" width="80" />
        <el-table-column prop="standardStatus" label="标准状态" width="100" />
        <el-table-column prop="description" label="标准描述" width="200" />
        <el-table-column prop="testItems" label="检验项目" width="120" />
        <el-table-column prop="acceptanceCriteria" label="验收标准" width="120" />
        <el-table-column prop="testMethods" label="检验方法" width="120" />
        <el-table-column prop="samplingPlan" label="取样方案" width="120" />
        <el-table-column prop="frequency" label="检验频率" width="100" >
          <template #default="{ row }">
            <el-tag :type="getStatusType(row.status)">
              {{ getStatusText(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="effectiveDate" label="生效日期" width="120" />
        <el-table-column prop="expiryDate" label="失效日期" width="120" />
        <el-table-column prop="approvalBy" label="批准人" width="100" />
        <el-table-column prop="approvalDate" label="批准日期" width="160" />
        <el-table-column prop="attachments" label="附件路径" width="120" />
        <el-table-column prop="notes" label="备注" width="100" />
        <el-table-column prop="status" label="状态" width="80" />
        <el-table-column prop="createTime" label="创建时间" width="160" />
        <el-table-column prop="updateTime" label="更新时间" width="160" />
        <el-table-column prop="createBy" label="创建人" width="100" />
        <el-table-column prop="updateBy" label="更新人" width="100" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button size="small" @click="showEditDialog(row)">编辑</el-button>
            <el-button size="small" type="info" @click="showDetailDialog(row)">详情</el-button>
            <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
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
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="800px"
      @close="resetForm"
    >
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="标准编号" prop="standardCode">
              <el-input v-model="form.standardCode" placeholder="请输入标准编号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="标准名称" prop="standardName">
              <el-input v-model="form.standardName" placeholder="请输入标准名称" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="适用药品" prop="drugId">
              <el-select v-model="form.drugId" placeholder="请选择药品（可选）" clearable style="width: 100%">
                <el-option
                  v-for="drug in drugList"
                  :key="drug.id"
                  :label="drug.name"
                  :value="drug.id"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="标准类别" prop="category">
              <el-input v-model="form.category" placeholder="请输入标准类别" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="标准描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            :rows="3"
            placeholder="请输入标准描述"
          />
        </el-form-item>
        <el-form-item label="质量要求" prop="requirements">
          <el-input
            v-model="form.requirements"
            type="textarea"
            :rows="4"
            placeholder="请输入质量要求"
          />
        </el-form-item>
        <el-form-item label="检测方法" prop="testMethods">
          <el-input
            v-model="form.testMethods"
            type="textarea"
            :rows="4"
            placeholder="请输入检测方法"
          />
        </el-form-item>
        <el-form-item label="验收标准" prop="acceptanceCriteria">
          <el-input
            v-model="form.acceptanceCriteria"
            type="textarea"
            :rows="4"
            placeholder="请输入验收标准"
          />
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="版本号" prop="version">
              <el-input v-model="form.version" placeholder="如：1.0" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态" style="width: 100%">
                <el-option label="生效" value="active" />
                <el-option label="失效" value="inactive" />
                <el-option label="草稿" value="draft" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="创建人" prop="createdBy">
              <el-input v-model="form.createdBy" placeholder="请输入创建人" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="生效日期" prop="effectiveDate">
              <el-date-picker
                v-model="form.effectiveDate"
                type="date"
                placeholder="选择生效日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="失效日期" prop="expiryDate">
              <el-date-picker
                v-model="form.expiryDate"
                type="date"
                placeholder="选择失效日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>

    <!-- 详情对话框 -->
    <el-dialog v-model="detailDialogVisible" title="质量标准详情" width="800px">
      <el-descriptions :column="2" border>
        <el-descriptions-item label="标准编号">{{ detailData.standardCode }}</el-descriptions-item>
        <el-descriptions-item label="标准名称">{{ detailData.standardName }}</el-descriptions-item>
        <el-descriptions-item label="适用药品">
          {{ detailData.drugName || '通用标准' }}
        </el-descriptions-item>
        <el-descriptions-item label="标准类别">{{ detailData.category }}</el-descriptions-item>
        <el-descriptions-item label="版本号">{{ detailData.version }}</el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="getStatusType(detailData.status)">
            {{ getStatusText(detailData.status) }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="生效日期">{{ detailData.effectiveDate }}</el-descriptions-item>
        <el-descriptions-item label="失效日期">{{ detailData.expiryDate }}</el-descriptions-item>
        <el-descriptions-item label="创建人">{{ detailData.createdBy }}</el-descriptions-item>
        <el-descriptions-item label="批准人">{{ detailData.approvedBy || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间" :span="2">{{ detailData.createTime }}</el-descriptions-item>
        <el-descriptions-item label="标准描述" :span="2">{{ detailData.description }}</el-descriptions-item>
        <el-descriptions-item label="质量要求" :span="2">{{ detailData.requirements }}</el-descriptions-item>
        <el-descriptions-item label="检测方法" :span="2">{{ detailData.testMethods }}</el-descriptions-item>
        <el-descriptions-item label="验收标准" :span="2">{{ detailData.acceptanceCriteria }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import axios from 'axios'

// 响应式数据
const loading = ref(false)
const standardList = ref([])
const drugList = ref([])
const stats = ref({})
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 搜索表单
const searchForm = reactive({
  standardCode: '',
  standardName: '',
  status: ''
})

// 新增/编辑表单
const dialogVisible = ref(false)
const dialogTitle = ref('新增标准')
const formRef = ref()
const form = reactive({
  id: null,
  standardCode: '',
  standardName: '',
  productCode: '',
  productName: '',
  standardType: '',
  version: '',
  standardStatus: '',
  description: '',
  testItems: '',
  acceptanceCriteria: '',
  testMethods: '',
  samplingPlan: '',
  frequency: '',
  effectiveDate: '',
  expiryDate: '',
  approvalBy: '',
  approvalDate: '',
  attachments: '',
  notes: '',
  status: null,
  createTime: '',
  updateTime: '',
  createBy: '',
  updateBy: ''
})

// 详情对话框
const detailDialogVisible = ref(false)
const detailData = ref({})

// 表单验证规则
const rules = {
  standardCode: [{ required: true, message: '请输入标准编号', trigger: 'blur' }],
  standardName: [{ required: true, message: '请输入标准名称', trigger: 'blur' }],
  category: [{ required: true, message: '请输入标准类别', trigger: 'blur' }],
  description: [{ required: true, message: '请输入标准描述', trigger: 'blur' }],
  requirements: [{ required: true, message: '请输入质量要求', trigger: 'blur' }],
  testMethods: [{ required: true, message: '请输入检测方法', trigger: 'blur' }],
  acceptanceCriteria: [{ required: true, message: '请输入验收标准', trigger: 'blur' }],
  version: [{ required: true, message: '请输入版本号', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }],
  createdBy: [{ required: true, message: '请输入创建人', trigger: 'blur' }]
}

// 获取标准列表
const getStandardList = async () => {
  loading.value = true
  try {
    const res = await axios.get('http://localhost:8080/api/qa/standard/list')
    if (res.data.code === 200) {
      standardList.value = res.data.data
    } else {
      ElMessage.error(res.data.message)
    }
  } catch (error) {
    console.error('获取标准列表失败:', error)
    ElMessage.error('获取标准列表失败')
  } finally {
    loading.value = false
  }
}

// 获取统计数据
const getStats = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/qa/standard/stats')
    if (res.data.code === 200) {
      stats.value = res.data.data
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

// 获取药品列表
const getDrugList = async () => {
  try {
    const res = await axios.get('http://localhost:8080/api/drugs/list')
    if (res.data.code === 200) {
      drugList.value = res.data.data
    }
  } catch (error) {
    console.error('获取药品列表失败:', error)
  }
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  getStandardList()
}

// 重置搜索
const resetSearch = () => {
  Object.assign(searchForm, {
    standardCode: '',
    standardName: '',
    status: ''
  })
  handleSearch()
}

// 显示新增对话框
const showAddDialog = () => {
  dialogTitle.value = '新增标准'
  dialogVisible.value = true
  resetForm()
}

// 显示编辑对话框
const showEditDialog = (row) => {
  dialogTitle.value = '编辑标准'
  dialogVisible.value = true
  Object.assign(form, row)
}

// 显示详情对话框
const showDetailDialog = (row) => {
  detailDialogVisible.value = true
  detailData.value = row
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        const url = form.id ? '/api/qa/standard/update' : '/api/qa/standard/add'
        const res = await axios[form.id ? 'put' : 'post'](`http://localhost:8080${url}`, form)
        
        if (res.data.code === 200) {
          ElMessage.success(res.data.message)
          dialogVisible.value = false
          getStandardList()
          getStats()
        } else {
          ElMessage.error(res.data.message)
        }
      } catch (error) {
        console.error('提交失败:', error)
        ElMessage.error('提交失败')
      }
    }
  })
}

// 删除标准
const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm('确定要删除这个质量标准吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    const res = await axios.delete(`http://localhost:8080/api/qa/standard/delete/${row.id}`)
    if (res.data.code === 200) {
      ElMessage.success(res.data.message)
      getStandardList()
      getStats()
    } else {
      ElMessage.error(res.data.message)
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除失败:', error)
      ElMessage.error('删除失败')
    }
  }
}

// 重置表单
const resetForm = () => {
  Object.assign(form, {
    id: null,
    standardCode: '',
    standardName: '',
    productCode: '',
    productName: '',
    standardType: '',
    version: '',
    standardStatus: '',
    description: '',
    testItems: '',
    acceptanceCriteria: '',
    testMethods: '',
    samplingPlan: '',
    frequency: '',
    effectiveDate: '',
    expiryDate: '',
    approvalBy: '',
    approvalDate: '',
    attachments: '',
    notes: '',
    status: null,
    createTime: '',
    updateTime: '',
    createBy: '',
    updateBy: ''
  })
  if (formRef.value) {
    formRef.value.resetFields()
  }
}

// 分页处理
const handleSizeChange = (val) => {
  pageSize.value = val
  getStandardList()
}

const handleCurrentChange = (val) => {
  currentPage.value = val
  getStandardList()
}

// 状态相关
const getStatusType = (status) => {
  const statusMap = {
    'active': 'success',
    'inactive': 'info',
    'draft': 'warning'
  }
  return statusMap[status] || 'info'
}

const getStatusText = (status) => {
  const statusMap = {
    'active': '生效',
    'inactive': '失效',
    'draft': '草稿'
  }
  return statusMap[status] || status
}

onMounted(() => {
  getStandardList()
  getStats()
  getDrugList()
})
</script>

<style scoped>
.quality-standard-list {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
  color: #333;
}

.search-card {
  margin-bottom: 20px;
}

.stats-row {
  margin-bottom: 20px;
}

.stat-card {
  text-align: center;
  padding: 20px;
}

.stat-number {
  font-size: 2em;
  font-weight: bold;
  color: #409EFF;
  margin-bottom: 10px;
}

.stat-label {
  color: #666;
  font-size: 0.9em;
}

.pagination {
  margin-top: 20px;
  text-align: right;
}

.text-muted {
  color: #999;
}
</style> 