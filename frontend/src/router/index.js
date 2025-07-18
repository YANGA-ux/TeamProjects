import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import ChangePassword from '../views/ChangePassword.vue'
import UserHome from '../views/UserHome.vue'
import AdminHome from '../views/AdminHome.vue'

const routes = [
    { path: '/', redirect: '/login' },
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { path: '/change-password', component: ChangePassword },
    { path: '/user', component: UserHome },
    { path: '/admin', component: AdminHome }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router