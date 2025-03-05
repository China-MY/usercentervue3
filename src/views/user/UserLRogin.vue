<template>
  <div id="userAuth">
    <div class="auth-container">
      <h2 class="title" v-if="isShowingLogin">淮高职社区登录</h2>
      <h2 class="title" v-else>淮高职社区注册</h2>

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
/* 新增颜色变量方便维护 */
:root {
  --primary-color: #4361ee;
  --hover-color: #3f37c9;
  --text-color: #2b2d42;
  --light-bg: rgba(255, 255, 255, 0.85);
}

#userAuth {
  /* 添加渐变遮罩提升文字可读性 */
  background:
    linear-gradient(to bottom right, rgba(67, 97, 238, 0.1), rgba(255, 255, 255, 0.3)),
    url('https://public.ysjf.com/mediastorm/material/material/%E9%9D%92%E5%B2%9B-12-%E5%85%A8%E6%99%AF-20250114.JPG');
  background-size: cover;
  background-position: center;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.auth-container {
  background: var(--light-bg);
  backdrop-filter: blur(12px);
  border-radius: 20px;
  padding: 40px;
  width: 90%;
  max-width: 500px;
  box-shadow:
    0 10px 30px rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(255, 255, 255, 0.3) inset;
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease;
}

.auth-container:hover {
  transform: translateY(-5px);
  box-shadow:
    0 15px 40px rgba(0, 0, 0, 0.2),
    0 0 0 1px rgba(255, 255, 255, 0.4) inset;
}

.title {
  text-align: center;
  color: var(--text-color);
  font-size: 2.2rem;
  margin-bottom: 2.5rem;
  position: relative;
  padding-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 60px;
  height: 3px;
  background: var(--primary-color);
  border-radius: 2px;
}

/* 优化输入框样式 */
.ant-input {
  border-radius: 8px;
  padding: 10px 15px;
  transition: all 0.3s ease;
  border: 2px solid #e9ecef;
}

.ant-input:hover,
.ant-input:focus {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
}

/* 增强按钮视觉效果 */
.fullscreen-btn {
  background: linear-gradient(135deg, var(--primary-color), var(--hover-color));
  border: none;
  height: 50px;
  border-radius: 12px;
  font-weight: 600;
  letter-spacing: 1px;
  transition:
    transform 0.2s ease,
    box-shadow 0.2s ease;
}

.fullscreen-btn:hover {
  transform: scale(1.02);
  box-shadow:
    0 5px 15px rgba(67, 97, 238, 0.4),
    0 0 0 1px rgba(255, 255, 255, 0.2) inset;
}

/* 优化切换链接样式 */
.ant-btn-link {
  color: var(--primary-color) !important;
  font-weight: 500;
  position: relative;
  padding: 0 0 2px;
}

.ant-btn-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background: currentColor;
  transition: width 0.3s ease;
}

.ant-btn-link:hover::after {
  width: 100%;
}

/* 优化错误提示样式 */
.ant-form-item-explain-error {
  font-size: 13px;
  margin-top: 6px;
  padding-left: 8px;
  position: relative;
}

.ant-form-item-explain-error::before {
  content: '!';
  position: absolute;
  left: 0;
  top: 1px;
  width: 16px;
  height: 16px;
  background: #ff4d4f;
  color: white;
  border-radius: 50%;
  text-align: center;
  line-height: 16px;
  font-size: 12px;
}

/* 优化移动端样式 */
@media (max-width: 576px) {
  .auth-container {
    padding: 24px;
    width: 95%;
  }

  .title {
    font-size: 1.8rem;
    margin-bottom: 2rem;
  }

  .ant-form-item-label {
    text-align: left !important;
  }

  .fullscreen-btn {
    height: 48px;
    font-size: 16px;
  }
}

/* 添加表单入场动画 */
@keyframes formEnter {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.auth-form {
  animation: formEnter 0.6s cubic-bezier(0.22, 1, 0.36, 1);
}
</style>
