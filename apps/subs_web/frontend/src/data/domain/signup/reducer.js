import { Map, OrderedSet } from 'immutable'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const signupStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const signupSuccess = (state, { data }) => {
  return resetState(state)
    .set('signed_up_email', data.email)
    .set('confirmation_sent_at', data.confirmation_sent_at)
}

const signupFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  signupStarted,
  signupSuccess,
  signupFailure,
}
