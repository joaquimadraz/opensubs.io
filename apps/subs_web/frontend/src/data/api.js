import axios from 'axios'

const postUsers = (params) => {
  return axios.post('/api/users', params)
}

const postUsersAuthenticate = (params) => {
  return axios.post('/api/users/authenticate', params)
}

export default {
  postUsers,
  postUsersAuthenticate,
}
