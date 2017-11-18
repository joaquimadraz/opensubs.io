import axios from 'axios'
import Cookies from 'js-cookie'

// public

const postUsers = (params) =>
  axios.post('/api/users', params)

const postUsersAuthenticate = (params) =>
  axios.post('/api/users/authenticate', params)

const postUsersConfirm = (params) =>
  axios.post('/api/users/confirm', params)

const postUsersRecoverPassword = (params) =>
  axios.post('/api/users/recover_password', params)

// authenticated

const authHeader = () => {
  const token = Cookies.get('auth-token')

  return token ? { Authorization: `Bearer ${token}` } : {}
}

const getUsersMe = () =>
  axios.get('/api/users/me', { headers: authHeader() })

const postSubscriptions = (params) =>
  axios.post('/api/subscriptions', params, { headers: authHeader() })

export default {
  postUsers,
  postUsersAuthenticate,
  postUsersConfirm,
  postUsersRecoverPassword,
  getUsersMe,
  postSubscriptions,
}
