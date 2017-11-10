import axios from 'axios'

const postSignup = (params) => {
  return axios.post('/api/users', params)
}

export default {
  postSignup,
}
