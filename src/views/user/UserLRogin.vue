<template>
  <div id="userAuth">
    <div class="auth-container">
      <h2 class="title" v-if="isShowingLogin">用户登录</h2>
      <h2 class="title" v-else>用户注册</h2>

      <!-- 登录注册表单 -->
      <a-form
        class="auth-form"
        :model="formData"
        :label-col="{ span: 6 }"
        :wrapper-col="{ span: 18 }"
        @finish="handleSubmit"
      >
        <!-- 表单字段 -->
        <a-form-item
          name="userAccount"
          label="账号"
          :rules="[{ required: true, message: '请输入账号' }]"
        >
          <a-input v-model:value="formData.userAccount" placeholder="请输入账号" />
        </a-form-item>

        <a-form-item
          name="userPassword"
          label="密码"
          :rules="[
            { required: true, message: '请输入密码' },
            { min: 8, message: '密码不少于 8 位' },
          ]"
        >
          <a-input-password v-model:value="formData.userPassword" placeholder="请输入密码" />
        </a-form-item>

        <!-- 注册表单特有的字段 -->
        <a-form-item
          name="checkPassword"
          label="确认密码"
          :rules="[
            { required: true, message: '请输入确认密码' },
            { min: 8, message: '确认密码不能小于 8 位' },
          ]"
          v-if="!isShowingLogin"
        >
          <a-input-password v-model:value="formData.checkPassword" placeholder="请输入确认密码" />
        </a-form-item>

        <a-form-item
          name="stuId"
          label="学号"
          :rules="[{ required: true, message: '请输入学号' }]"
          v-if="!isShowingLogin"
        >
          <a-input v-model:value="formData.stuId" placeholder="请输入学号" />
        </a-form-item>

        <!-- 提交按钮 -->
        <a-form-item :wrapper-col="{ offset: 6, span: 18 }">
          <a-button type="primary" html-type="submit" class="fullscreen-btn">
            {{ isShowingLogin ? '登录' : '注册' }}
          </a-button>
        </a-form-item>

        <!-- 切换按钮 -->
        <a-form-item>
          <div style="text-align: center">
            <span v-if="isShowingLogin">还没有账号？</span>
            <span v-else>已有账号？</span>
            <a-button type="link" @click="switchForm" style="margin-left: 10px">
              {{ isShowingLogin ? '去注册' : '去登录' }}
            </a-button>
          </div>
        </a-form-item>
      </a-form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { userLogin, userRegister } from '@/api/user.ts'
import { message } from 'ant-design-vue'
import { useLoginUserStore } from '@/stores/useLoginUserStore.ts'

const router = useRouter()
const loginUserStore = useLoginUserStore()

// 表单数据
const formData = reactive({
  userAccount: '',
  userPassword: '',
  checkPassword: '',
  stuId: '',
})

// 是否显示登录表单
const isShowingLogin = ref(true)

// 切换表单
const switchForm = () => {
  isShowingLogin.value = !isShowingLogin.value
  resetForm()
}

// 重置表单
const resetForm = () => {
  formData.userAccount = ''
  formData.userPassword = ''
  formData.checkPassword = ''
  formData.stuId = ''
}

// 提交表单
const handleSubmit = async () => {
  if (isShowingLogin.value) {
    // 登录操作
    const res = await userLogin(formData)
    if (res.data.code === 0 && res.data.data) {
      await loginUserStore.fetchLoginUser()
      message.success('登录成功')
      router.push({ path: '/', replace: true })
    } else {
      message.error('登录失败')
    }
  } else {
    // 注册操作
    if (formData.userPassword !== formData.checkPassword) {
      message.error('两次输入的密码不一致')
      return
    }
    const res = await userRegister(formData)
    if (res.data.code === 0 && res.data.data) {
      message.success('注册成功')
      // 注册成功后切换到登录表单
      isShowingLogin.value = true
      resetForm()
    } else {
      message.error('注册失败，' + res.data.description)
    }
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap');

#userAuth {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: url('https://public.ysjf.com/mediastorm/material/material/%E9%9D%92%E5%B2%9B-12-%E5%85%A8%E6%99%AF-20250114.JPG')
    no-repeat center center fixed;
  background-size: cover;
  background-color: #f0f2f5;
}

.auth-container {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 15px;
  padding: 32px;
  max-width: 600px;
  width: 100%;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.auth-container:hover {
  box-shadow: 0 8px 40px rgba(0, 0, 0, 0.15);
  transform: translateY(-4px);
}

.auth-form {
  background: transparent;
  border-radius: 15px;
}

.ant-form-item-label {
  color: #333;
  font-weight: 500;
}

.ant-input,
.ant-btn {
  border-radius: 8px;
  font-size: 14px;
}

.title {
  font-size: 30px;
  font-weight: 600;
  margin-bottom: 38px;
  text-align: center;
  color: #fff;
  text-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
}

.fullscreen-btn {
  background: linear-gradient(45deg, #2a73e8, #1f55d4);
  border: none;
  color: white;
  width: 100%;
  height: 60px;
  font-size: 20px;
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 2px;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(42, 115, 232, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
}

.fullscreen-btn:hover {
  background: linear-gradient(45deg, #1f55d4, #2a73e8);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(42, 115, 232, 0.8);
}

.fullscreen-btn:active {
  transform: translateY(0);
  box-shadow: 0 2px 10px rgba(42, 115, 232, 0.6);
}

.ant-btn-link {
  color: #1890ff;
  margin-top: 16px;
}

.ant-form-item-error-tip {
  margin-top: 8px;
  color: #f5222d;
  font-size: 12px;
}

@media (max-width: 768px) {
  .auth-container {
    padding: 24px;
  }

  .title {
    font-size: 24px;
    margin-bottom: 24px;
  }

  .ant-form-item {
    margin-bottom: 20px;
  }

  .fullscreen-btn {
    height: 50px;
    font-size: 16px;
  }
}
</style>
