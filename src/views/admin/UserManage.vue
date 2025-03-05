<template>
  <div id="userManage">
    <a-input-search
      style="max-width: 320px; margin-bottom: 20px"
      v-model:value="searchValue"
      placeholder="输入用户名搜索"
      enter-button="搜索"
      size="large"
      @search="onSearch"
    />

    <a-button type="primary" @click="resetsearch" size="large">刷新</a-button>
    <a-table :columns="columns" :data-source="data">
      <template #bodyCell="{ column, record }">
        <template v-if="column.dataIndex === 'avatarUrl'">
          <a-image :src="record.avatarUrl" :width="120" />
        </template>
        <template v-else-if="column.dataIndex === 'gender'">
          <div v-if="record.gender === 0">
            <a-tag color="green">女</a-tag>
          </div>
          <div v-else-if="record.gender === 1">
            <a-tag color="blue">男</a-tag>
          </div>
        </template>
        <template v-else-if="column.dataIndex === 'userStatus'">
          <div v-if="record.userStatus === 0">
            <a-tag color="green">正常</a-tag>
          </div>
          <div v-else-if="record.userStatus === 1">
            <a-tag color="red">封号</a-tag>
          </div>
        </template>
        <template v-else-if="column.dataIndex === 'userRole'">
          <div v-if="record.userRole === 0">
            <a-tag color="green">普通用户</a-tag>
          </div>
          <div v-else-if="record.userRole === 1">
            <a-tag color="blue">管理员</a-tag>
          </div>
          <div v-else-if="record.userRole === 2">
            <a-tag color="red">毕业校友</a-tag>
          </div>
          <div v-else-if="record.userRole === 3">
            <a-tag color="green">在校学生</a-tag>
          </div>
        </template>
        <template v-else-if="column.dataIndex === 'createTime'">
          {{ dayjs(record.createTime).format('YYYY-MM-DD HH:mm:ss') }}
        </template>
        <template v-else-if="column.key === 'action'">
          <a-button type="primary" @click="doInfoUser(record.id)">修改</a-button>
          <a-button danger @click="doDelete(record.id)">删除</a-button>
        </template>
      </template>
    </a-table>
    <div class="edituserinfo">
      <a-modal
        v-model:open="open"
        title="修改用户信息"
        :confirm-loading="confirmLoading"
        :footer="null"
        centered
        style="width: 800px"
        @ok="handleOk"
      >
        <a-form :label-col="labelCol" :wrapper-col="wrapperCol">
          <a-form-item label="用户昵称" v-bind="validateInfos.username">
            <a-input v-model:value="modelRef.username" />
          </a-form-item>
          <a-form-item label="学号" v-bind="validateInfos.stuId">
            <a-input v-model:value="modelRef.stuId" />
          </a-form-item>
          <a-form-item label="班级" v-bind="validateInfos.className">
            <a-input v-model:value="modelRef.className" />
          </a-form-item>
          <a-form-item label="头像" v-bind="validateInfos.avatarUrl">
            <a-input v-model:value="modelRef.avatarUrl" />
          </a-form-item>
          <a-form-item label="性别" v-bind="validateInfos.gender">
            <a-select v-model:value="modelRef.gender">
              <a-select-option :value="0">女</a-select-option>
              <a-select-option :value="1">男</a-select-option>
            </a-select>
          </a-form-item>
          <a-form-item label="手机号" v-bind="validateInfos.phone">
            <a-input v-model:value="modelRef.phone" />
          </a-form-item>
          <a-form-item label="邮箱" v-bind="validateInfos.email">
            <a-input v-model:value="modelRef.email" />
          </a-form-item>
          <a-form-item label="用户状态" v-bind="validateInfos.userStatus">
            <a-select v-model:value="modelRef.userStatus">
              <a-select-option :value="0">正常</a-select-option>
              <a-select-option :value="1">封号</a-select-option>
            </a-select>
          </a-form-item>
          <a-form-item label="用户角色" v-bind="validateInfos.userRole">
            <a-select v-model:value="modelRef.userRole">
              <a-select-option :value="0">普通用户</a-select-option>
              <a-select-option :value="1">管理员</a-select-option>
              <a-select-option :value="2">毕业校友</a-select-option>
              <a-select-option :value="3">在校学生</a-select-option>
            </a-select>
          </a-form-item>
          <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
            <a-button type="primary" @click.prevent="onSubmit">确定</a-button>
            <a-button style="margin-left: 10px" @click="open = false">取消</a-button>
          </a-form-item>
        </a-form>
      </a-modal>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { Form } from 'ant-design-vue'
import { deleteUser, searchUsers, IdInfoUser, updateUser } from '@/api/user'
import { message } from 'ant-design-vue'
import dayjs from 'dayjs'

const searchValue = ref('')
const onSearch = () => {
  fetchData(searchValue.value)
}
const fetchData = async (username = '') => {
  const res = await searchUsers(username)
  if (res.data.data) {
    data.value = res.data.data
  } else {
    message.error('搜索失败')
  }
}
const resetsearch = () => {
  searchValue.value = ''
  fetchData()
}
const columns = [
  {
    title: 'id',
    dataIndex: 'id',
  },
  {
    title: '用户昵称',
    dataIndex: 'username',
  },
  {
    title: '账号',
    dataIndex: 'userAccount',
  },
  {
    title: '学号',
    dataIndex: 'stuId',
  },
  {
    title: '班级',
    dataIndex: 'className',
  },
  {
    title: '头像',
    dataIndex: 'avatarUrl',
  },
  {
    title: '性别',
    dataIndex: 'gender',
  },
  {
    title: '手机号',
    dataIndex: 'phone',
  },
  {
    title: '邮箱',
    dataIndex: 'email',
  },
  {
    title: '用户状态',
    dataIndex: 'userStatus',
  },
  {
    title: '用户角色',
    dataIndex: 'userRole',
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
  },
  {
    title: '操作',
    key: 'action',
  },
]
const data = ref([])
fetchData()

const doInfoUser = async (id: string) => {
  open.value = true
  if (!id) {
    return
  }
  const res = await IdInfoUser(id)
  if (res.data.code === 0) {
    modelRef.id = res.data.data.id
    modelRef.username = res.data.data.username
    modelRef.stuId = res.data.data.stuId
    modelRef.className = res.data.data.className
    modelRef.avatarUrl = res.data.data.avatarUrl
    modelRef.gender = res.data.data.gender
    modelRef.phone = res.data.data.phone
    modelRef.email = res.data.data.email
    modelRef.userStatus = res.data.data.userStatus
    modelRef.userRole = res.data.data.userRole
  }
}
const open = ref<boolean>(false)
const confirmLoading = ref<boolean>(false)
const handleOk = () => {
  confirmLoading.value = true
  setTimeout(() => {
    open.value = false
    confirmLoading.value = false
  }, 2000)
}
const useForm = Form.useForm
const labelCol = { span: 4 }
const wrapperCol = { span: 14 }
const modelRef = reactive({
  id: '',
  username: '',
  stuId: '',
  className: '',
  avatarUrl: '',
  gender: '',
  phone: '',
  email: '',
  userStatus: '',
  userRole: '',
})
const rulesRef = reactive({
  username: [
    {
      required: true,
      message: '请输入用户昵称',
    },
  ],
  stuId: [
    {
      required: true,
      message: '请输入学号',
    },
  ],
  className: [
    {
      required: true,
      message: '请输入班级',
    },
  ],
  avatarUrl: [
    {
      required: true,
      message: '请输入头像链接地址',
    },
  ],
  gender: [
    {
      required: true,
      message: '请输入性别',
    },
  ],
  phone: [
    {
      required: true,
      message: '请输入手机号',
    },
  ],
  email: [
    {
      required: true,
      message: '请输入邮箱',
    },
  ],
})

const { validate, validateInfos } = useForm(modelRef, rulesRef, {})
const onSubmit = () => {
  validate().then(() => {
    updateUser(modelRef).then((res) => {
      if (res.data.code === 0) {
        message.success('修改成功')
        open.value = false
        resetsearch()
      } else {
        message.error('修改失败')
      }
    })
  })
}

const doDelete = async (id: string) => {
  if (!id) {
    return
  }
  const res = await deleteUser(id)
  if (res.data.code === 0) {
    message.success('删除成功')
    resetsearch()
  } else {
    message.error('删除失败')
  }
}
</script>

<style scoped>
#userManage {
  padding: 20px;
}
</style>
