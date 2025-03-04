import axios from 'axios'

// 获取当前环境
const ENV = import.meta.env

// 获取基础 URL
const getBaseUrl = () => {
  if (ENV.MODE === 'development') {
    return 'http://localhost:8888'
  } else {
    return 'http://vps001.myxz.fun'
  }
}

// 创建 Axios 实例
const myAxios = axios.create({
  baseURL: getBaseUrl(),
  timeout: 10000,
  withCredentials: true,
})

// 请求拦截器
myAxios.interceptors.request.use(
  (config) => {
    // 在请求发送前，可以添加通用的请求头或参数
    // 例如，添加 Token
    // config.headers.Authorization = `Bearer ${token}`;

    // 打印请求日志
    // console.log('Request:', config)

    // 返回请求配置
    return config
  },
  (error) => {
    // 请求错误处理
    // console.error('Request Error:', error)
    return Promise.reject(error)
  },
)

// 响应拦截器
myAxios.interceptors.response.use(
  (response) => {
    // 响应成功处理
    const { data } = response
    // 打印响应日志
    // console.log('Response:', response)
    // 统一处理未登录状态
    if (data.code === 40100) {
      // 不是获取用户信息接口，且不是登录页面，则跳转到登录页面
      if (
        !response.config.url?.includes('user/current') &&
        !window.location.pathname.includes('/')
      ) {
        // 使用路由跳转逻辑
        window.location.href = `/?redirect=${encodeURIComponent(window.location.href)}`
      }
    }
    return response
  },
  (error) => {
    // 响应错误处理
    // console.error('Response Error:', error)
    // 统一错误处理逻辑
    if (error.response) {
      // 服务器响应错误
      // console.error('Server Error:', error.response.data)
    } else if (error.request) {
      // 请求发送失败
      // console.error('Request Failed:', error.request)
    } else {
      // 其他错误
      // console.error('Error:', error.message)
    }
    return Promise.reject(error)
  },
)

// 导出 Axios 实例
export default myAxios
