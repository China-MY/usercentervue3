import myAxios from '@/request'

/**
 * 用户注册
 * @param params
 */
export const userRegister = async (params: any) => {
  return myAxios.request({
    url: '/user/register',
    method: 'POST',
    data: params,
  })
}

/**
 * 用户登录
 * @param params
 */
export const userLogin = async (params: any) => {
  return myAxios.request({
    url: '/user/login',
    method: 'POST',
    data: params,
  })
}

/**
 * 用户注销
 * @param params
 */
export const userLogout = async (params: any) => {
  return myAxios.request({
    url: '/user/logout',
    method: 'POST',
    data: params,
  })
}

/**
 * 获取当前用户
 */
export const getCurrentUser = async () => {
  return myAxios.request({
    url: '/user/current',
    method: 'GET',
  })
}

/**
 * 查询用户
 * @param username
 */
export const searchUsers = async (username: any) => {
  return myAxios.request({
    url: '/user/search',
    method: 'GET',
    params: {
      username,
    },
  })
}

/**
 * 根据id获取用户信息
 * @param id
 */
export const IdInfoUser = async (id: string) => {
  return myAxios.request({
    url: '/user/idInfo',
    method: 'POST',
    data: id,
    // 关键点：要传递 JSON 格式的值
    headers: {
      'Content-Type': 'application/json',
    },
  })
}

/**
 * 删除用户
 * @param id
 */
export const deleteUser = async (id: string) => {
  return myAxios.request({
    url: '/user/delete',
    method: 'POST',
    data: id,
    // 关键点：要传递 JSON 格式的值
    headers: {
      'Content-Type': 'application/json',
    },
  })
}

/**
 * 更新用户
 * @param params
 */
export const updateUser = async (params: any) => {
  return myAxios.request({
    url: '/user/update',
    method: 'POST',
    data: params,
    headers: {
      'Content-Type': 'application/json',
    },
  })
}
/**
 * 根据id获取用户信息（普通用户修改密码用）
 * @param id
 */
export const setidpasswordInfo = async (id: string) => {
  return myAxios.request({
    url: '/user/setidpasswordInfo',
    method: 'POST',
    data: id,
    // 关键点：要传递 JSON 格式的值
    headers: {
      'Content-Type': 'application/json',
    },
  })
}

/**
 * 用户修改密码
 * @param params
 */
export const userSetPassword = async (params: any) => {
  return myAxios.request({
    url: '/user/setpassword',
    method: 'POST',
    data: params,
    headers: {
      'Content-Type': 'application/json',
    },
  })
}
