import { Map, OrderedSet } from 'immutable'

import {
  SIGNUP_STARTED,
  SIGNUP_SUCCESS,
  SIGNUP_FAILURE,
} from './signup/action'

import {
  signupStarted,
  signupSuccess,
  signupFailure,
} from './signup/reducer'

const initialState = Map({
  remoteCall: Map(),
})

const signupReducer = (state = initialState, action) => {
  switch (action.type) {
    case SIGNUP_STARTED:
      return signupStarted(state)
    case SIGNUP_SUCCESS:
      return signupSuccess(state, action)
    case SIGNUP_FAILURE:
      return signupFailure(state, action)
    default:
      return state
  }
}

export default signupReducer
export { initialState }
