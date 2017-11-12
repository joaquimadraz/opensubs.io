import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const loginStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const loginSuccess = (state, { data }) => {
  return resetState(state)
}

const loginFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

const userJustConfirmed = (state) => {
  return state.set('justConfirmed', true)
}

export {
  loginStarted,
  loginSuccess,
  loginFailure,
  userJustConfirmed,
}
