<template>
  <div id="globalHeader">
    <div class="title-bar">
      <img class="logo" src="../assets/logo.png" alt="logo" />
      <div class="title">淮高职用户中心</div>
    </div>
    <a-menu v-model:selectedKeys="current" mode="horizontal" :items="items" />
    <div class="user-login-status">
      <a-button type="primary" href="/user/login">登录</a-button>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { h, ref } from 'vue'
import { CrownOutlined, HomeOutlined } from '@ant-design/icons-vue'
import type { MenuProps } from 'ant-design-vue'

const items = ref<MenuProps['items']>([
  {
    key: '/',
    icon: () => h(HomeOutlined),
    label: '主页',
    title: '主页',
  },
  {
    key: '/user/login',
    label: '用户登录',
    title: '用户登录',
  },
  {
    key: '/user/register',
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
