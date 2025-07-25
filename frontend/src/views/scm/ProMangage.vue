<template>
  <div class="pro-management-container">
    <div class="header">
      <h2>采购管理系统</h2>
      <el-button type="primary" @click="showAddDialog">新增采购</el-button>
    </div>

    <div class="search-container">
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="物料名称">
          <el-input v-model="searchForm.materialName" placeholder="请输入物料名称"></el-input>
        </el-form-item>
        <el-form-item label="供应商">
          <el-select v-model="searchForm.supplierId" placeholder="请选择供应商" clearable>
            <el-option
                v-for="supplier in supplierList"
                :key="supplier.id"
                :label="supplier.supplierName"
                :value="supplier.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <el-table
        :data="materialList"
        border
        style="width: 100%"
        v-loading="loading"
        @selection-change="handleSelectionChange">
      <el-table-column
          type="selection"
          width="55">
      </el-table-column>
      <el-table-column
          prop="materialCode"
          label="物料编号"
          width="120">
      </el-table-column>
      <el-table-column
          prop="materialName"
          label="物料名称"
          width="150">
      </el-table-column>
      <el-table-column
          prop="specification"
          label="规格"
          width="180">
      </el-table-column>
      <el-table-column
          prop="unit"
          label="单位"
          width="80">
      </el-table-column>
      <el-table-column
          prop="currentStock"
          label="当前库存"
          width="100">
        <template #default="{row}">
          <el-tag :type="getStockTagType(row)">{{ row.currentStock }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          prop="minStock"
          label="最小库存"
          width="100">
      </el-table-column>
      <el-table-column
          prop="maxStock"
          label="最大库存"
          width="100">
      </el-table-column>
      <el-table-column
          prop="supplierName"
          label="供应商"
          width="150">
      </el-table-column>
      <el-table-column
          prop="unitPrice"
          label="单价"
          width="100">
        <template #default="{row}">
          {{ row.unitPrice }} {{ row.currency }}
        </template>
      </el-table-column>
      <el-table-column
          label="操作"
          width="200">
        <template #default="{row}">
          <el-button size="small" @click="viewSupplierDetail(row.supplierId)">供应商详情</el-button>
          <el-button size="small" type="primary" @click="showPurchaseDialog(row)">采购</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination-container">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pagination.currentPage"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pagination.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total">
      </el-pagination>
    </div>

    <!-- 供应商详情对话框 -->
    <el-dialog
        title="供应商详情"
        v-model="supplierDialogVisible"
        width="50%">
      <el-descriptions :column="2" border>
        <el-descriptions-item label="供应商编号">{{ currentSupplier.supplierCode }}</el-descriptions-item>
        <el-descriptions-item label="供应商名称">{{ currentSupplier.supplierName }}</el-descriptions-item>
        <el-descriptions-item label="供应商类型">{{ currentSupplier.supplierType }}</el-descriptions-item>
        <el-descriptions-item label="联系人">{{ currentSupplier.contactPerson }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ currentSupplier.contactPhone }}</el-descriptions-item>
        <el-descriptions-item label="联系邮箱">{{ currentSupplier.contactEmail }}</el-descriptions-item>
        <el-descriptions-item label="地址" :span="2">{{ currentSupplier.address }}</el-descriptions-item>
        <el-descriptions-item label="营业执照号">{{ currentSupplier.businessLicense }}</el-descriptions-item>
        <el-descriptions-item label="税号">{{ currentSupplier.taxNumber }}</el-descriptions-item>
        <el-descriptions-item label="供应商状态">{{ currentSupplier.supplierStatus }}</el-descriptions-item>
        <el-descriptions-item label="风险等级">{{ currentSupplier.riskLevel }}</el-descriptions-item>
        <el-descriptions-item label="绩效评级">{{ currentSupplier.performanceRating }}</el-descriptions-item>
        <el-descriptions-item label="资质到期日期">{{ currentSupplier.qualificationExpiryDate }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <el-button @click="supplierDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>

    <!-- 采购对话框 -->
    <el-dialog
        title="物料采购"
        v-model="purchaseDialogVisible"
        width="40%">
      <el-form :model="purchaseForm" label-width="120px" :rules="purchaseRules" ref="purchaseFormRef">
        <el-form-item label="物料编号" prop="materialCode">
          <el-input v-model="purchaseForm.materialCode" disabled></el-input>
        </el-form-item>
        <el-form-item label="物料名称" prop="materialName">
          <el-input v-model="purchaseForm.materialName" disabled></el-input>
        </el-form-item>
        <el-form-item label="供应商" prop="supplierName">
          <el-input v-model="purchaseForm.supplierName" disabled></el-input>
        </el-form-item>
        <el-form-item label="当前库存" prop="currentStock">
          <el-input v-model="purchaseForm.currentStock" disabled></el-input>
        </el-form-item>
        <el-form-item label="采购数量" prop="quantity">
          <el-input-number v-model="purchaseForm.quantity" :min="1" :max="99999"></el-input-number>
        </el-form-item>
        <el-form-item label="单价" prop="unitPrice">
          <el-input v-model="purchaseForm.unitPrice" disabled>
            <template #append>{{ purchaseForm.currency }}</template>
          </el-input>
        </el-form-item>
        <el-form-item label="总价">
          <el-input :value="purchaseForm.quantity * purchaseForm.unitPrice" disabled>
            <template #append>{{ purchaseForm.currency }}</template>
          </el-input>
        </el-form-item>
        <el-form-item label="预计到货日期" prop="expectedDate">
          <el-date-picker
              v-model="purchaseForm.expectedDate"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input
              type="textarea"
              :rows="2"
              placeholder="请输入备注信息"
              v-model="purchaseForm.notes">
          </el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="purchaseDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitPurchase">确认采购</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'

export default {
  name: 'ProManagement',
  setup() {
    // 搜索表单
    const searchForm = ref({
      materialName: '',
      supplierId: ''
    })

    // 分页信息
    const pagination = ref({
      currentPage: 1,
      pageSize: 10,
      total: 0
    })

    // 加载状态
    const loading = ref(false)

    // 物料列表
    const materialList = ref([])

    // 供应商列表
    const supplierList = ref([])

    // 选中的行
    const selectedRows = ref([])

    // 供应商对话框可见性
    const supplierDialogVisible = ref(false)

    // 当前查看的供应商
    const currentSupplier = ref({})

    // 采购对话框可见性
    const purchaseDialogVisible = ref(false)

    // 采购表单
    const purchaseForm = ref({
      materialId: '',
      materialCode: '',
      materialName: '',
      supplierId: '',
      supplierName: '',
      currentStock: 0,
      quantity: 1,
      unitPrice: 0,
      currency: '',
      expectedDate: '',
      notes: ''
    })

    // 采购表单验证规则
    const purchaseRules = ref({
      quantity: [
        { required: true, message: '请输入采购数量', trigger: 'blur' },
        { type: 'number', min: 1, message: '采购数量必须大于0', trigger: 'blur' }
      ],
      expectedDate: [
        { required: true, message: '请选择预计到货日期', trigger: 'change' }
      ]
    })

    // 获取库存标签类型
    const getStockTagType = (row) => {
      if (row.currentStock < row.minStock) {
        return 'danger' // 库存不足
      } else if (row.currentStock > row.maxStock) {
        return 'warning' // 库存过多
      } else {
        return 'success' // 库存正常
      }
    }

    // 处理选择变化
    const handleSelectionChange = (val) => {
      selectedRows.value = val
    }

    // 处理分页大小变化
    const handleSizeChange = (val) => {
      pagination.value.pageSize = val
      fetchMaterialList()
    }

    // 处理当前页变化
    const handleCurrentChange = (val) => {
      pagination.value.currentPage = val
      fetchMaterialList()
    }

    // 处理搜索
    const handleSearch = () => {
      pagination.value.currentPage = 1
      fetchMaterialList()
    }

    // 重置搜索
    const resetSearch = () => {
      searchForm.value = {
        materialName: '',
        supplierId: ''
      }
      handleSearch()
    }

    // 查看供应商详情
    const viewSupplierDetail = (supplierId) => {
      // 在实际应用中，这里应该调用API获取供应商详情
      const supplier = supplierList.value.find(item => item.id === supplierId)
      if (supplier) {
        currentSupplier.value = supplier
        supplierDialogVisible.value = true
      } else {
        ElMessage.error('未找到供应商信息')
      }
    }

    // 显示采购对话框
    const showPurchaseDialog = (row) => {
      purchaseForm.value = {
        materialId: row.id,
        materialCode: row.materialCode,
        materialName: row.materialName,
        supplierId: row.supplierId,
        supplierName: row.supplierName,
        currentStock: row.currentStock,
        quantity: 1,
        unitPrice: row.unitPrice,
        currency: row.currency,
        expectedDate: '',
        notes: ''
      }
      purchaseDialogVisible.value = true
    }

    // 显示新增对话框
    const showAddDialog = () => {
      if (selectedRows.value.length === 0) {
        ElMessage.warning('请至少选择一条物料记录')
        return
      }
      showPurchaseDialog(selectedRows.value[0])
    }

    // 提交采购
    const submitPurchase = () => {
      // 在实际应用中，这里应该调用API提交采购订单
      ElMessageBox.confirm('确认提交采购订单吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 模拟API调用
        setTimeout(() => {
          ElMessage.success('采购订单提交成功')
          purchaseDialogVisible.value = false
          // 刷新物料列表
          fetchMaterialList()
        }, 500)
      }).catch(() => {
        ElMessage.info('已取消采购')
      })
    }

    // 获取物料列表
    const fetchMaterialList = async () => {
      loading.value = true
      try {
        // 模拟API调用
        // 在实际应用中，这里应该调用后端API获取数据
        const mockData = [
          {
            id: 1,
            materialCode: 'MAT001',
            materialName: '阿司匹林原料',
            materialType: '原料药',
            category: 'API',
            specification: '99.5%纯度',
            unit: 'kg',
            unitPrice: 150.00,
            currency: 'CNY',
            currentStock: 100.00,
            minStock: 50.00,
            maxStock: 200.00,
            supplierId: 1,
            supplierName: '阿司匹林供应商',
            supplierCode: 'SUP001'
          },
          {
            id: 2,
            materialCode: 'MAT002',
            materialName: '布洛芬原料',
            materialType: '原料药',
            category: 'API',
            specification: '99.8%纯度',
            unit: 'kg',
            unitPrice: 200.00,
            currency: 'CNY',
            currentStock: 80.00,
            minStock: 40.00,
            maxStock: 180.00,
            supplierId: 1,
            supplierName: '布洛芬供应商',
            supplierCode: 'SUP002'
          },
          {
            id: 6,
            materialCode: '666',
            materialName: '666',
            materialType: '666',
            category: '666',
            specification: '666',
            unit: '666',
            unitPrice: 656.00,
            currency: '666',
            currentStock: 666.00,
            minStock: 66.00,
            maxStock: 66.00,
            supplierId: 7,
            supplierName: '6',
            supplierCode: '6'
          }
        ]

        // 过滤数据
        let filteredData = mockData.filter(item => {
          const nameMatch = searchForm.value.materialName
              ? item.materialName.includes(searchForm.value.materialName)
              : true
          const supplierMatch = searchForm.value.supplierId
              ? item.supplierId == searchForm.value.supplierId
              : true
          return nameMatch && supplierMatch
        })

        // 模拟分页
        const start = (pagination.value.currentPage - 1) * pagination.value.pageSize
        const end = start + pagination.value.pageSize
        materialList.value = filteredData.slice(start, end)
        pagination.value.total = filteredData.length
      } catch (error) {
        ElMessage.error('获取物料列表失败: ' + error.message)
      } finally {
        loading.value = false
      }
    }

    // 获取供应商列表
    const fetchSupplierList = async () => {
      try {
        // 模拟API调用
        // 在实际应用中，这里应该调用后端API获取数据
        supplierList.value = [
          {
            id: 1,
            supplierCode: 'SUP001',
            supplierName: '阿司匹林供应商',
            supplierType: '药品原料',
            contactPerson: '张经理',
            contactPhone: '13800138000',
            contactEmail: 'zhang@supplier.com',
            address: '北京市海淀区',
            businessLicense: '123456789',
            taxNumber: '987654321',
            supplierStatus: 'ACTIVE',
            riskLevel: '低',
            performanceRating: 'A',
            qualificationExpiryDate: '2026-12-31'
          },
          {
            id: 7,
            supplierCode: '6',
            supplierName: '6',
            supplierType: '6',
            contactPerson: '6',
            contactPhone: '6',
            contactEmail: '6@6.com',
            address: 'xxxxx',
            supplierStatus: '8',
            riskLevel: '',
            performanceRating: '',
            qualificationExpiryDate: ''
          }
        ]
      } catch (error) {
        ElMessage.error('获取供应商列表失败: ' + error.message)
      }
    }

    // 初始化数据
    onMounted(() => {
      fetchSupplierList()
      fetchMaterialList()
    })

    return {
      searchForm,
      pagination,
      loading,
      materialList,
      supplierList,
      selectedRows,
      supplierDialogVisible,
      currentSupplier,
      purchaseDialogVisible,
      purchaseForm,
      purchaseRules,
      getStockTagType,
      handleSelectionChange,
      handleSizeChange,
      handleCurrentChange,
      handleSearch,
      resetSearch,
      viewSupplierDetail,
      showPurchaseDialog,
      showAddDialog,
      submitPurchase
    }
  }
}
</script>

<style scoped>
.pro-management-container {
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.search-container {
  margin-bottom: 20px;
}

.search-form {
  display: flex;
  flex-wrap: wrap;
}

.pagination-container {
  margin-top: 20px;
  text-align: right;
}

.el-descriptions {
  margin-top: 20px;
}

.el-tag {
  margin-right: 10px;
}
</style>