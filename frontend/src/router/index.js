import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import ChangePassword from '../views/ChangePassword.vue'
import UserHome from '../views/UserHome.vue'
import AdminHome from '../views/AdminHome.vue'
import TestPage from '../views/TestPage.vue'
import SimpleTest from '../views/SimpleTest.vue'

// 研发管理模块
import CompoundList from '../views/rd/CompoundList.vue'
// import ExperimentList from '../views/rd/ExperimentList.vue'
// import LiteratureList from '../views/rd/LiteratureList.vue'

// 生产管理模块
import ProductionHome from '../views/prod/ProductionHome.vue'
import BatchList from '../views/prod/BatchList.vue'
import QualityStandardList from '../views/prod/QualityStandardList.vue'

// 供应链管理模块
// import MaterialList from '../views/scm/MaterialList.vue'
// import SupplierList from '../views/scm/SupplierList.vue'

// 系统管理模块
// import UserList from '../views/sys/UserList.vue'
// import RoleList from '../views/sys/RoleList.vue'

const routes = [
    { path: '/', redirect: '/login' },
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { path: '/change-password', component: ChangePassword },
    { path: '/user', component: UserHome },
    { path: '/admin', component: AdminHome },
    { path: '/test', component: TestPage },
    { path: '/simple', component: SimpleTest },
    
    // 研发管理模块路由
    { path: '/rd/compounds', component: CompoundList },
    // { path: '/rd/experiments', component: ExperimentList },
    // { path: '/rd/literature', component: LiteratureList },
    
    // 生产管理模块路由
    { path: '/prod', component: ProductionHome },
    { path: '/prod/batches', component: BatchList },
    { path: '/prod/standards', component: QualityStandardList },
    
    // 供应链管理模块路由
    // { path: '/scm/materials', component: MaterialList },
    // { path: '/scm/suppliers', component: SupplierList },
    
    // 系统管理模块路由
    // { path: '/sys/users', component: UserList },
    // { path: '/sys/roles', component: RoleList }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router