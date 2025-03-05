<template>
  <div id="globalHeader">
    <div>
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
        <a-col flex="350px">
          <div v-if="loginUserStore.loginUser.id">
            <a-image :src="loginUserStore.loginUser.avatarUrl" :width="120" />
            {{ loginUserStore.loginUser.username ?? '无名' }}
            <a-button type="primary" @click="handleSetPassword">修改密码</a-button>
            <a-button type="primary" @click="handleLogout">注销</a-button>
          </div>
          <div v-else>
            <a-button type="primary" href="/">登录</a-button>
          </div>
        </a-col>
      </a-row>
    </div>
    <div class="edituserinfo">
      <!--      <a-modal-->
      <!--        v-model:open="open"-->
      <!--        title="修改密码"-->
      <!--        :confirm-loading="confirmLoading"-->
      <!--        :footer="null"-->
      <!--        centered-->
      <!--        style="width: 800px"-->
      <!--        @ok="handleOk"-->
      <!--      >-->
      <!--        <a-form :label-col="labelCol" :wrapper-col="wrapperCol">-->
      <!--          <a-form-item label="原密码" v-bind="validateInfos.userPassword">-->
      <!--            <a-input v-model:value="modelRef.userPassword" type="password" />-->
      <!--          </a-form-item>-->
      <!--          <a-form-item label="新密码" v-bind="validateInfos.NewuserPassword">-->
      <!--            <a-input v-model:value="modelRef.NewuserPassword" type="password" />-->
      <!--          </a-form-item>-->
      <!--          <a-form-item label="确认新密码" v-bind="validateInfos.checkNewPassword">-->
      <!--            <a-input v-model:value="modelRef.checkNewPassword" type="password" />-->
      <!--          </a-form-item>-->
      <!--          <a-form-item :wrapper-col="{ span: 14, offset: 4 }">-->
      <!--            <a-button type="primary" @click.prevent="onSubmit">确定</a-button>-->
      <!--            <a-button style="margin-left: 10px" @click="open = false">取消</a-button>-->
      <!--          </a-form-item>-->
      <!--        </a-form>-->
      <!--      </a-modal>-->
    </div>
  </div>
</template>

<script lang="ts" setup>
import { h, ref } from 'vue'
import { CrownOutlined, HomeOutlined } from '@ant-design/icons-vue'
import { type MenuProps, message } from 'ant-design-vue'
import { useRouter } from 'vue-router'
import { useLoginUserStore } from '@/stores/useLoginUserStore.ts'
import { userLogout } from '@/api/user.ts'
const loginUserStore = useLoginUserStore()
const router = useRouter()

// 注销
const handleLogout = async () => {
  const res = await userLogout({})
  if (res.data.code === 0) {
    message.success('注销成功')
    loginUserStore.setLoginUser({})
    router.go(0)
  }
}

const open = ref<boolean>(false)
// 修改密码
const handleSetPassword = () => {
  open.value = true
}

// 定义并初始化 current 变量
const current = ref<string[]>(['mail'])
// 监听路由变化，并更新 current 变量
router.afterEach(() => {
  current.value = [router.currentRoute.value.path]
})
// 菜单点击事件
const DMenuClick = ({ key }: { key: string }) => {
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
