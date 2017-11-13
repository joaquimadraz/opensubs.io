import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import {
  LOGIN_STARTED,
  LOGIN_FAILURE,
} from './login/action'

import {
  RECOVER_PASSWORD_STARTED,
  RECOVER_PASSWORD_SUCCESS,
  RECOVER_PASSWORD_FAILURE,
} from './recoverPassword/action'

import {
  loginStarted,
  loginFailure,
} from './login/reducer'

// TODO: Refactor login actions/reducers. Two actions on the login page.
// login
// - login
//   - action.js
//   - reducer.js
// - recoverPassword
//   - action.js
//   - reducer.js

import {
  recoverPasswordStarted,
  recoverPasswordSuccess,
  recoverPasswordFailure,
} from './recoverPassword/reducer'

const initialState = Map({
  remoteCall: new RemoteCall(),
})

const loginReducer = (state = initialState, action) => {
  switch (action.type) {
    case LOGIN_STARTED:
      return loginStarted(state)
    case LOGIN_FAILURE:
      return loginFailure(state, action)
    case RECOVER_PASSWORD_STARTED:
      return recoverPasswordStarted(state)
    case RECOVER_PASSWORD_SUCCESS:
      return recoverPasswordSuccess(state, action)
    case RECOVER_PASSWORD_FAILURE:
      return recoverPasswordFailure(state, action)
    default:
      return state
  }
}

export default loginReducer
export { initialState }
