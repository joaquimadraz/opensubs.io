import { OrderedSet, Map } from 'immutable'
import { parseSubscription } from 'data/domain/subscriptions/Subscription'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state =>
  state.set('remoteCall', new RemoteCall())
    .set('ids', OrderedSet())
    .set('entities', Map())

const getAllSubscriptionsStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const getAllSubscriptionsSuccess = (state, { data, meta }) => {
  const newState = resetState(state)
    .setIn(['avgs', 'monthly'], meta.avg.monthly)
    .setIn(['avgs', 'yearly'], meta.avg.yearly)
    .setIn(['month', 'total'], meta.month.total)
    .setIn(['month', 'subscriptions'], meta.month.subscriptions.map(parseSubscription))

  return data.reduce((result, subscription) => (
    result.update('ids', value => value.add(subscription.id))
      .setIn(['entities', subscription.id], parseSubscription(subscription))
  ), newState)
}

const getAllSubscriptionsFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  getAllSubscriptionsStarted,
  getAllSubscriptionsSuccess,
  getAllSubscriptionsFailure,
}
