<template>
  <div class="literature-list">
    <el-card>
      <div class="header">
        <span>文献管理</span>
        <el-button type="primary" @click="showAddDialog = true">新增文献</el-button>
      </div>
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="标题">
          <el-input v-model="searchForm.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="作者">
          <el-input v-model="searchForm.authors" placeholder="请输入作者" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="fetchList">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="literatureList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="literatureCode" label="文献编号" width="120" />
        <el-table-column prop="title" label="标题" width="200" />
        <el-table-column prop="authors" label="作者" width="120" />
        <el-table-column prop="journal" label="期刊名称" width="150" />
        <el-table-column prop="doi" label="DOI号" width="120" />
        <el-table-column prop="issn" label="ISSN号" width="100" />
        <el-table-column prop="publishDate" label="发布日期" width="120" />
        <el-table-column prop="abstractContent" label="摘要" width="200" />
        <el-table-column prop="keywords" label="关键词" width="120" />
        <el-table-column prop="category" label="文献分类" width="100" />
        <el-table-column prop="tags" label="标签" width="100" />
        <el-table-column prop="filePath" label="文件路径" width="150" />
        <el-table-column prop="fileType" label="文件类型" width="100" />
        <el-table-column prop="fileSize" label="文件大小" width="100" />
        <el-table-column prop="citation" label="引用格式" width="150" />
        <el-table-column prop="notes" label="备注" width="150" />
        <el-table-column prop="readCount" label="阅读次数" width="100" />
        <el-table-column prop="downloadCount" label="下载次数" width="100" />
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button size="small" @click="editLiterature(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="deleteLiterature(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 新增/编辑弹窗 -->
    <el-dialog v-model="showAddDialog" :title="editMode ? '编辑文献' : '新增文献'">
      <el-form :model="form" label-width="100px">
        <el-form-item label="文献编号">
          <el-input v-model="form.literatureCode" />
        </el-form-item>
        <el-form-item label="标题">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="作者">
          <el-input v-model="form.authors" />
        </el-form-item>
        <el-form-item label="期刊名称">
          <el-input v-model="form.journal" />
        </el-form-item>
        <el-form-item label="DOI号">
          <el-input v-model="form.doi" />
        </el-form-item>
        <el-form-item label="ISSN号">
          <el-input v-model="form.issn" />
        </el-form-item>
        <el-form-item label="发布日期">
          <el-date-picker v-model="form.publishDate" type="date" placeholder="选择日期" />
        </el-form-item>
        <el-form-item label="摘要">
          <el-input v-model="form.abstractContent" type="textarea" />
        </el-form-item>
        <el-form-item label="关键词">
          <el-input v-model="form.keywords" />
        </el-form-item>
        <el-form-item label="文献分类">
          <el-input v-model="form.category" />
        </el-form-item>
        <el-form-item label="标签">
          <el-input v-model="form.tags" />
        </el-form-item>
        <el-form-item label="文件路径">
          <el-input v-model="form.filePath" />
        </el-form-item>
        <el-form-item label="文件类型">
          <el-input v-model="form.fileType" />
        </el-form-item>
        <el-form-item label="文件大小">
          <el-input v-model="form.fileSize" type="number" />
        </el-form-item>
        <el-form-item label="引用格式">
          <el-input v-model="form.citation" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.notes" type="textarea" />
        </el-form-item>
        <el-form-item label="阅读次数">
          <el-input v-model="form.readCount" type="number" />
        </el-form-item>
        <el-form-item label="下载次数">
          <el-input v-model="form.downloadCount" type="number" />
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

const literatureList = ref([])
const showAddDialog = ref(false)
const editMode = ref(false)
const form = reactive({})
const searchForm = reactive({ title: '', authors: '' })

const fetchList = async () => {
  const { data } = await axios.get('/api/literature/list')
  literatureList.value = data.data || []
}

const resetSearch = () => {
  searchForm.title = ''
  searchForm.authors = ''
  fetchList()
}

const editLiterature = (row) => {
  Object.assign(form, row)
  editMode.value = true
  showAddDialog.value = true
}

const deleteLiterature = (id) => {
  ElMessageBox.confirm('确定要删除该文献吗？', '提示', { type: 'warning' })
    .then(async () => {
      await axios.delete(`/api/literature/delete/${id}`)
      ElMessage.success('删除成功')
      fetchList()
    })
}

const submitForm = async () => {
  if (editMode.value) {
    await axios.post('/api/literature/update', form)
    ElMessage.success('更新成功')
  } else {
    await axios.post('/api/literature/add', form)
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
.literature-list .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.search-form {
  margin-bottom: 12px;
}
</style>
