import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import { LOGOUT_SUCCESS } from '../currentUser/logout/action'

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

import {
  GET_ALL_SUBSCRIPTIONS_STARTED,
  GET_ALL_SUBSCRIPTIONS_SUCCESS,
  GET_ALL_SUBSCRIPTIONS_FAILURE,
} from './getAllSubscriptions/action'

import {
  getAllSubscriptionsStarted,
  getAllSubscriptionsSuccess,
  getAllSubscriptionsFailure,
} from './getAllSubscriptions/reducer'

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
    case GET_ALL_SUBSCRIPTIONS_STARTED:
      return getAllSubscriptionsStarted(state)
    case GET_ALL_SUBSCRIPTIONS_SUCCESS:
      return getAllSubscriptionsSuccess(state, action)
    case GET_ALL_SUBSCRIPTIONS_FAILURE:
      return getAllSubscriptionsFailure(state, action)
    case LOGOUT_SUCCESS:
      return initialState
    default:
      return state
  }
}

export default subscriptionsReducer
export { initialState }
