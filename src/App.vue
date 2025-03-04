<template>
  <div id="app">
    <div v-if="loginUserStore.loginUser.username !== '未登录'">
      <BasicLayout />
    </div>
    <div v-else>
      <UserLRogin />
    </div>
  </div>
</template>

<script setup lang="ts">
import BasicLayout from '@/layouts/BasicLayout.vue'
import { useLoginUserStore } from '@/stores/useLoginUserStore.ts'
import UserLRogin from '@/views/user/UserLRogin.vue'

const loginUserStore = useLoginUserStore()
loginUserStore.fetchLoginUser()
</script>

<style></style>
