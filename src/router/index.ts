import { createRouter, createWebHistory } from 'vue-router'
import UserHome from '../views/UserHome.vue'
import UserManage from '@/views/admin/UserManage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'UserHome',
      component: UserHome,
    },
    {
      path: '/admin/userManage',
      name: 'adminUserManage',
      component: UserManage,
    },
  ],
})

export default router
