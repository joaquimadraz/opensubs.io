import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import {
  LOGIN_STARTED,
  LOGIN_SUCCESS,
  LOGIN_FAILURE,
} from './login/action'

import {
  loginStarted,
  loginSuccess,
  loginFailure,
} from './login/reducer'

const initialState = Map({
  remoteCall: new RemoteCall(),
})

const loginReducer = (state = initialState, action) => {
  switch (action.type) {
    case LOGIN_STARTED:
      return loginStarted(state)
    case LOGIN_SUCCESS:
      return loginSuccess(state, action)
    case LOGIN_FAILURE:
      return loginFailure(state, action)
    default:
      return state
  }
}

export default loginReducer
export { initialState }
