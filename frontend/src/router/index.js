import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import ChangePassword from '../views/ChangePassword.vue'
import UserHome from '../views/UserHome.vue'
import AdminHome from '../views/AdminHome.vue'
import TestPage from '../views/TestPage.vue'
import SimpleTest from '../views/SimpleTest.vue'

// 研发管理模块
import RdHome from "../views/rd/RdHome.vue";
import CompoundList from '../views/rd/CompoundList.vue'
import ExperimentList from '../views/rd/ExperimentList.vue'
import LiteratureList from '../views/rd/LiteratureList.vue'

// 生产管理模块
import ProductionHome from '../views/prod/ProductionHome.vue'
import BatchList from '../views/prod/BatchList.vue'
import QualityStandardList from '../views/prod/QualityStandardList.vue'

// 供应链管理模块
import MaterialList from '../views/scm/MaterialList.vue'
import SupplierList from '../views/scm/SupplierList.vue'
import ScmHome from "../views/scm/ScmHome.vue";
import ProMangage from "../views/scm/ProMangage.vue";

import Self from "../views/Self.vue";


// 系统管理模块
import Syshome from "../views/sys/Syshome.vue";
import ProductionMonitoring from "../views/prod/ProductionMonitoring.vue";


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
    { path: '/self', component: Self },
    // 研发管理模块路由
    {path: '/rd',component: RdHome},
    { path: '/rd/compounds', component: CompoundList },
    { path: '/rd/experiments', component: ExperimentList },
    { path: '/rd/literature', component: LiteratureList },
    {path: '/prod/monitoring',component: ProductionMonitoring},

    // 生产管理模块路由
    { path: '/prod', component: ProductionHome },
    { path: '/prod/batches', component: BatchList },
    { path: '/prod/standards', component: QualityStandardList },


    // 供应链管理模块路由
    {path: '/scm',component: ScmHome},
    { path: '/scm/materials', component: MaterialList },
    { path: '/scm/suppliers', component: SupplierList },
    {path: '/scm/mangage',component: ProMangage},

    // 系统管理模块路由
    { path: '/sys/Syshome', component: Syshome },  // 匹配大小写路径
    { path: '/sys/syshome', component: Syshome }, // 可选：添加小写版本
    { path: '/sys/sysuser', redirect: '/sys/Syshome' } // 可选：重定向旧路径
]
const router = createRouter({
    history: createWebHistory(),
    routes
})
router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        const username = localStorage.getItem('username');
        if (!username) {
            next('/login');
        } else {
            next();
        }
    } else {
        next();
    }
});
export default router