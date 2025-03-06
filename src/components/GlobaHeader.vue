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
      <a-modal
        v-model:open="open"
        title="修改密码"
        :confirm-loading="confirmLoading"
        :footer="null"
        centered
        style="width: 800px"
        @ok="handleOk"
      >
        <a-form :label-col="labelCol" :wrapper-col="wrapperCol">
          <a-form-item label="原密码" v-bind="validateInfos.userPassword">
            <a-input-password v-model:value="modelRef.userPassword" type="password" />
          </a-form-item>
          <a-form-item label="新密码" v-bind="validateInfos.userNewPassword">
            <a-input-password v-model:value="modelRef.userNewPassword" type="password" />
          </a-form-item>
          <a-form-item label="确认新密码" v-bind="validateInfos.checkNewPassword">
            <a-input-password v-model:value="modelRef.checkNewPassword" type="password" />
          </a-form-item>
          <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
            <a-button type="primary" @click.prevent="onSubmit">确定</a-button>
            <a-button style="margin-left: 10px" @click="open = false">取消</a-button>
          </a-form-item>
          <p>提示：{{ tips }}</p>
          <a-button type="primary" @click="handleLogout">重新登录</a-button>
        </a-form>
      </a-modal>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { h, reactive, ref } from 'vue'
import { CrownOutlined, HomeOutlined } from '@ant-design/icons-vue'
import { Form, type MenuProps, message } from 'ant-design-vue'
import { useRouter } from 'vue-router'
import { useLoginUserStore } from '@/stores/useLoginUserStore.ts'
import { setidpasswordInfo, userLogout, userSetPassword } from '@/api/user.ts'
const loginUserStore = useLoginUserStore()
const router = useRouter()
const tips = ref('')

// 注销
const handleLogout = async () => {
  const res = await userLogout({})
  if (res.data.code === 0) {
    message.success('注销成功')
    loginUserStore.setLoginUser({})
    router.go(0)
  }
}
//  修改密码配置项
const confirmLoading = ref<boolean>(false)
const open = ref<boolean>(false)
const useForm = Form.useForm
const labelCol = { span: 4 }
const wrapperCol = { span: 14 }

// 修改密码
const handleSetPassword = async () => {
  const id = loginUserStore.loginUser.id
  const res = await setidpasswordInfo(id)
  open.value = true
  if (!id) {
    return
  }
  if (res.data.code === 0) {
    modelRef.id = res.data.data.id
    modelRef.userPassword = res.data.data.userPassword
    modelRef.userNewPassword = res.data.data.userNewPassword
    modelRef.checkNewPassword = res.data.data.checkNewPassword
  }
}
const handleOk = () => {
  confirmLoading.value = true
  setTimeout(() => {
    open.value = false
    confirmLoading.value = false
  }, 2000)
}
const modelRef = reactive({
  id: '',
  userPassword: '',
  userNewPassword: '',
  checkNewPassword: '',
})
const rulesRef = reactive({
  userPassword: [
    {
      required: true,
      message: '请输入原密码',
    },
  ],
  userNewPassword: [
    {
      required: true,
      message: '请输入新密码',
    },
  ],
  checkNewPassword: [
    {
      required: true,
      message: '请输入再次输入密码',
    },
  ],
})
const { validate, validateInfos } = useForm(modelRef, rulesRef, {})
const onSubmit = () => {
  validate().then(() => {
    userSetPassword(modelRef).then((res) => {
      tips.value = res.data.message
      if (res.data.code === 0) {
        message.success('修改密码成功')
      }
      if (res.data.code !== null) {
        message.error('修改密码失败')
      }
    })
  })
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
