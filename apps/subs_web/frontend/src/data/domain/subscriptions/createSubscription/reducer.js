import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const createSubscriptionStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const createSubscriptionSuccess = (state, { data }) => {
  return resetState(state)
}

const createSubscriptionFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  createSubscriptionStarted,
  createSubscriptionSuccess,
  createSubscriptionFailure,
}
