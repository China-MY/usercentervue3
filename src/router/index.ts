import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import UserLogin from '@/views/user/UserLogin.vue'
import UserRegister from '@/views/user/UserRegister.vue'
import UserManage from '@/views/admin/UserManage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/user/login',
      name: 'userLogin',
      component: UserLogin,
    },
    {
      path: '/user/register',
      name: 'userRegister',
      component: UserRegister,
    },
    {
      path: '/admin/userManage',
      name: 'adminUserManage',
      component: UserManage,
    },
  ],
})

export default router
