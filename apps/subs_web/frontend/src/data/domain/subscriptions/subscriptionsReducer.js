import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import {
  CREATE_SUBSCRIPTION_STARTED,
  CREATE_SUBSCRIPTION_SUCCESS,
  CREATE_SUBSCRIPTION_FAILURE,
} from './createSubscription/action'

import {
  createSubscriptionStarted,
  createSubscriptionSuccess,
  createSubscriptionFailure,
} from './createSubscription/reducer'

const initialState = Map({
  entities: Map(),
  ids: OrderedSet(),
  remoteCall: new RemoteCall(),
})

const subscriptionsReducer = (state = initialState, action) => {
  switch (action.type) {
    case CREATE_SUBSCRIPTION_STARTED:
      return createSubscriptionStarted(state)
    case CREATE_SUBSCRIPTION_SUCCESS:
      return createSubscriptionSuccess(state, action)
    case CREATE_SUBSCRIPTION_FAILURE:
      return createSubscriptionFailure(state, action)
    default:
      return state
  }
}

export default subscriptionsReducer
export { initialState }
