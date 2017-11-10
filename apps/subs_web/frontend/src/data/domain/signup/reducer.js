import { Map, OrderedSet } from 'immutable'

const resetState = state => (
  state.setIn(['remoteCall', 'loading'], false)
       .setIn(['remoteCall', 'error'], null)
)

const signupStarted = (state) => (
  resetState(state).setIn(['remoteCall', 'loading'], true)
)

const signupSuccess = (state, { data }) => {
  return state
}

const signupFailure = (state, { error }) => {
  const response = error.response

  return state.setIn(['remoteCall', 'loading'], false)
              .setIn(['remoteCall', 'error'], response)
}

export {
  signupStarted,
  signupSuccess,
  signupFailure,
}
