import { parseSubscription } from 'data/domain/subscriptions/Subscription'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const getSubscriptionStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const getSubscriptionSuccess = (state, { data }) => {
  const subscription = parseSubscription(data)

  return resetState(state)
    .update('ids', (set) => {
      if (set.has(subscription.id) > 0) { return set }

      return set.add(subscription.id)
    })
    .setIn(['entities', subscription.id], parseSubscription(subscription))
}

const getSubscriptionFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  getSubscriptionStarted,
  getSubscriptionSuccess,
  getSubscriptionFailure,
}
