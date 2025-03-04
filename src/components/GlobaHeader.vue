<template>
  <div id="globalHeader">
    <a-row :wrap="false">
      <a-col flex="200px">
        <div class="title-bar">
          <img class="logo" src="../assets/logo.png" alt="logo" />
          <div class="title">淮高职用户中心</div>
        </div>
      </a-col>
      <a-col flex="auto">
        <a-menu
          v-model:selectedKeys="current"
          mode="horizontal"
          :items="items"
          @click="DMenuClick"
        ></a-menu>
      </a-col>
      <a-col flex="80px">
        <div class="user-login-status">
          <div v-if="loginUserStore.loginUser.id">
            {{ loginUserStore.loginUser.username ?? '无名' }}
          </div>
          <div v-else>
            <a-button type="primary" href="/user/login">登录</a-button>
          </div>
        </div>
      </a-col>
    </a-row>
  </div>
</template>

<script lang="ts" setup>
import { h, ref } from 'vue'
import { CrownOutlined, HomeOutlined } from '@ant-design/icons-vue'
import { type MenuProps } from 'ant-design-vue'
import { useRouter } from 'vue-router'
import { useLoginUserStore } from '@/stores/useLoginUserStore.ts'

const loginUserStore = useLoginUserStore()
const router = useRouter()

// 定义并初始化 current 变量
const current = ref<string[]>(['mail'])
//监听路由变化，并更新 current 变量
router.afterEach(() => {
  current.value = [router.currentRoute.value.path]
})
// 菜单点击事件
const DMenuClick = function ({ key }: { key: string }) {
  router.push({ path: key })
}
// 菜单项
const items = ref<MenuProps['items']>([
  {
    key: '/',
    icon: () => h(HomeOutlined),
    label: '主页',
    title: '主页',
  },
  {
    key: '/user/login',
    icon: () => h(HomeOutlined),
    label: '用户登录',
    title: '用户登录',
  },
  {
    key: '/user/register',
    icon: () => h(HomeOutlined),
    label: '用户注册',
    title: '用户注册',
  },
  {
    key: '/admin/userManage',
    icon: () => h(CrownOutlined),
    label: '用户管理',
    title: '用户管理',
  },
  {
    key: 'others',
    label: h('a', { href: 'http://vps001.myxz.fun', target: '_blank' }, '明裕学长'),
    title: '明裕学长',
  },
  {
    key: '/logout',
    label: h('a', { href: 'http://127.0.0.1:8888/user/logout' }, '注销登录'),
    title: '注销登录',
  },
])
</script>

<style scoped>
.title-bar {
  display: flex;
  align-items: center;
}

.title {
  color: black;
  font-size: 18px;
  margin-left: 16px;
}

.logo {
  height: 48px;
}
</style>
