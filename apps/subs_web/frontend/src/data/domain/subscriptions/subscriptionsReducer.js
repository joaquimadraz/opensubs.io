import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

const initialState = Map({
  entities: Map(),
  ids: OrderedSet(),
  remoteCall: new RemoteCall(),
})

const subscriptionsReducer = (state = initialState, action) => {
  return state
}

export default subscriptionsReducer
export { initialState }
