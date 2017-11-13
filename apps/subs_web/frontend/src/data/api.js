import axios from 'axios'

const postUsers = (params) => {
  return axios.post('/api/users', params)
}

const postUsersAuthenticate = (params) => {
  return axios.post('/api/users/authenticate', params)
}

const postUsersConfirm = (params) => {
  return axios.post('/api/users/confirm', params)
}

const postUsersRecoverPassword = (params) => {
  return axios.post('/api/users/recover_password', params)
}

export default {
  postUsers,
  postUsersAuthenticate,
  postUsersConfirm,
  postUsersRecoverPassword
}
