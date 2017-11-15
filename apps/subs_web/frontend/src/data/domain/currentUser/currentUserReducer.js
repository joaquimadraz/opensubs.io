import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'
import Cookies from 'js-cookie'

import { LOGIN_SUCCESS } from '../login/action'
import { GET_CURRENT_USER_SUCCESS } from './getCurrentUser/action'

import { setCurrentUser } from './setCurrentUser/reducer'

const initialState = null

const saveAuthToken = (user) => {
  Cookies.set('auth-token', user.auth_token, {
    expires: Number(process.env.AUTH_TOKEN_EXPIRES || 10),
  })
}

const currentUserReducer = (state = initialState, action) => {
  switch (action.type) {
    case LOGIN_SUCCESS:
      const currentUser = setCurrentUser(state, action)
      saveAuthToken(currentUser)
      return currentUser
    case GET_CURRENT_USER_SUCCESS:
      return setCurrentUser(state, action)
    default:
      return state
  }
}

export default currentUserReducer
export { initialState }
