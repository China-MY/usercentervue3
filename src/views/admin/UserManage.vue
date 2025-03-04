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

    <a-table
      :columns="columns"
      :data-source="data"
      :loading="loading"
      :pagination="{ pageSize: 10 }"
    >
      <template #bodyCell="{ column, record }">
        <template v-if="column.dataIndex === 'avatarUrl'">
          <a-image :src="record.avatarUrl" :width="120" />
        </template>

        <template v-else-if="column.dataIndex === 'userRole'">
          <a-tag :color="record.userRole === 1 ? 'green' : 'blue'">
            {{ getUserRole(record.userRole) }}
          </a-tag>
        </template>

        <template v-else-if="column.dataIndex === 'gender'">
          <a-tag :color="record.gender === 1 ? 'green' : 'blue'">
            {{ getGender(record.gender) }}
          </a-tag>
        </template>

        <template v-else-if="column.dataIndex === 'createTime'">
          {{ dayjs(record.createTime).format('YYYY-MM-DD HH:mm:ss') }}
        </template>

        <template v-else-if="column.key === 'action'">
          <div style="display: flex">
            <a-button type="primary" @click="doUpdate(record.id)">修改</a-button>
            <a-button
              :danger="record.userRole !== 1"
              :disabled="record.userRole === 1"
              @click="doDelete(record.id)"
            >
              删除
            </a-button>
          </div>
        </template>
      </template>
    </a-table>

    <div class="eidt">
      <a-modal
        v-model:open="visible"
        title="更新用户信息"
        ok-text="确定"
        cancel-text="取消"
        @ok="onOk"
      >
        <a-form ref="formRef" :model="formState" layout="vertical" name="form_in_modal">
          <a-form-item
            name="username"
            label="用户名"
            :rules="[{ required: true, message: '请输入用户名' }]"
          >
            <a-input v-model:value="formState.username" />
          </a-form-item>

          <a-form-item
            name="stuId"
            label="学号"
            :rules="[{ required: true, message: '请输入学号' }]"
          >
            <a-input v-model:value="formState.stuId" />
          </a-form-item>

          <a-form-item
            name="className"
            label="班级"
            :rules="[{ required: true, message: '请输入班级' }]"
          >
            <a-input v-model:value="formState.className" />
          </a-form-item>

          <a-form-item
            name="avatarUrl"
            label="头像地址"
            :rules="[{ required: true, message: '请输入头像地址' }]"
          >
            <a-input v-model:value="formState.avatarUrl" />
          </a-form-item>

          <a-form-item
            name="gender"
            label="性别"
            :rules="[{ required: true, message: '请选择性别' }]"
          >
            <a-radio-group v-model:value="formState.gender">
              <a-radio value="1">男</a-radio>
              <a-radio value="0">女</a-radio>
            </a-radio-group>
          </a-form-item>

          <a-form-item
            name="phone"
            label="电话"
            :rules="[{ required: true, message: '请输入电话' }]"
          >
            <a-input v-model:value="formState.phone" />
          </a-form-item>

          <a-form-item
            name="email"
            label="邮箱"
            :rules="[{ required: true, message: '请输入邮箱' }]"
          >
            <a-input v-model:value="formState.email" />
          </a-form-item>

          <a-form-item
            name="userStatus"
            label="用户状态"
            :rules="[{ required: true, message: '请选择用户状态' }]"
          >
            <a-radio-group v-model:value="formState.userStatus">
              <a-radio value="1">启用</a-radio>
              <a-radio value="0">停用</a-radio>
            </a-radio-group>
          </a-form-item>

          <a-form-item
            name="isDelete"
            label="是否删除"
            :rules="[{ required: true, message: '请选择是否删除' }]"
          >
            <a-radio-group v-model:value="formState.isDelete">
              <a-radio value="1">是</a-radio>
              <a-radio value="0">否</a-radio>
            </a-radio-group>
          </a-form-item>

          <a-form-item
            name="userRole"
            label="用户角色"
            :rules="[{ required: true, message: '请选择用户角色' }]"
          >
            <a-radio-group v-model:value="formState.userRole">
              <a-radio value="1">管理员</a-radio>
              <a-radio value="0">普通用户</a-radio>
            </a-radio-group>
          </a-form-item>
        </a-form>
      </a-modal>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'
import { message } from 'ant-design-vue'
import dayjs from 'dayjs'
import { deleteUser, searchUsers, updateUser } from '@/api/user'

const searchValue = ref('')
const loading = ref(false)
const visible = ref(false)

const onSearch = () => {
  fetchData(searchValue.value)
}

interface Values {
  username: string
  stuId: string
  className: string
  avatarUrl: string
  gender: string
  phone: string
  email: string
  userStatus: string
  isDelete: string
  userRole: string
}

const formRef = ref()
const formState = reactive<Values>({
  username: '',
  stuId: '',
  className: '',
  avatarUrl: '',
  gender: '',
  phone: '',
  email: '',
  userStatus: '',
  isDelete: '',
  userRole: '',
})

const onOk = () => {
  formRef.value
    .validateFields()
    .then((values) => {
      visible.value = false
      formRef.value.resetFields()
      updateUser(formState)
        .then((res) => {
          console.log('Success:', values)
          if (res.data.code === 0) {
            message.success('修改成功')
            fetchData(searchValue.value)
          } else {
            message.error('修改失败')
          }
        })
        .catch((info) => {
          message.error('修改失败')
        })
    })
    .catch((info) => {
      message.error('修改失败')
    })
}

const doUpdate = (id: string) => {
  visible.value = true
  if (!id) return
  searchUsers(id).then((res) => {
    if (res.data.code === 0) {
      formState.username = res.data.data.username
      formState.stuId = res.data.data.stuId
      formState.className = res.data.data.className
      formState.avatarUrl = res.data.data.avatarUrl
      formState.gender = res.data.data.gender
      formState.phone = res.data.data.phone
      formState.email = res.data.data.email
      formState.userStatus = res.data.data.userStatus
      formState.isDelete = res.data.data.isDelete
      formState.userRole = res.data.data.userRole
    }
  })
}

const doDelete = (id: string) => {
  if (!id) return
  deleteUser(id)
    .then((res) => {
      if (res.data.code === 0) {
        message.success('删除成功')
        fetchData(searchValue.value)
      } else {
        message.error('删除失败')
      }
    })
    .catch((err) => {
      console.error(err)
      message.error('删除失败')
    })
}

const columns = [
  {
    title: 'ID',
    dataIndex: 'id',
  },
  {
    title: '用户名',
    dataIndex: 'username',
  },
  {
    title: '账号',
    dataIndex: 'userAccount',
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
    title: '创建时间',
    dataIndex: 'createTime',
  },
  {
    title: '用户角色',
    dataIndex: 'userRole',
  },
  {
    title: '操作',
    key: 'action',
  },
]

const data = ref([])

const fetchData = async (username = '') => {
  loading.value = true
  try {
    const res = await searchUsers(username)
    if (res.data.data) {
      data.value = res.data.data
    } else {
      message.error('获取数据失败')
    }
  } catch (err) {
    console.error(err)
    message.error('获取数据失败')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchData()
})

const getUserRole = (userRole) => (userRole === 1 ? '管理员' : '普通用户')
const getGender = (gender) => (gender === 1 ? '男' : '女')
</script>

<style scoped>
#userManage {
  padding: 20px;
}

.eidt {
  margin-top: 20px;
}

.ant-table-tbody > tr > td {
  padding: 16px;
}

.ant-form-item {
  margin-bottom: 24px;
}
</style>
