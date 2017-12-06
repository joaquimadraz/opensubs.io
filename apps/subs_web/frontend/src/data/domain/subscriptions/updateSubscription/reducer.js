import { parseSubscription } from 'data/domain/subscriptions/Subscription'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const updateSubscriptionStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const updateSubscriptionSuccess = (state, { data }) => {
  const subscription = parseSubscription(data)

  return resetState(state).setIn(['entities', subscription.id], subscription)
}

const updateSubscriptionFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  updateSubscriptionStarted,
  updateSubscriptionSuccess,
  updateSubscriptionFailure,
}
