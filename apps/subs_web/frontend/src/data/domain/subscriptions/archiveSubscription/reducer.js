import { parseSubscription } from 'data/domain/subscriptions/Subscription'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const archiveSubscriptionStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const archiveSubscriptionSuccess = (state, { data }) => {
  const subscription = parseSubscription(data)

  return resetState(state)
    .update('ids', set => set.delete(subscription.id))
    .update('entities', map => map.delete(subscription.id))
}

const archiveSubscriptionFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  archiveSubscriptionStarted,
  archiveSubscriptionSuccess,
  archiveSubscriptionFailure,
}
