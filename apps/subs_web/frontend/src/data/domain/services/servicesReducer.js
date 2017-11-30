import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import {
  GET_ALL_SERVICES_STARTED,
  GET_ALL_SERVICES_SUCCESS,
  GET_ALL_SERVICES_FAILURE,
} from './getAllServices/action'

import {
  getAllServicesStarted,
  getAllServicesSuccess,
  getAllServicesFailure,
} from './getAllServices/reducer'

const initialState = Map({
  entities: Map(),
  ids: OrderedSet(),
  remoteCall: new RemoteCall(),
})

const servicesReducer = (state = initialState, action) => {
  switch (action.type) {
    case GET_ALL_SERVICES_STARTED:
      return getAllServicesStarted(state)
    case GET_ALL_SERVICES_SUCCESS:
      return getAllServicesSuccess(state, action)
    case GET_ALL_SERVICES_FAILURE:
      return getAllServicesFailure(state, action)
    default:
      return state
  }
}

export default servicesReducer
export { initialState }
