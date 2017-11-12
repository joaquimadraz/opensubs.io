import { Map, OrderedSet } from 'immutable'
import RemoteCall from 'data/domain/RemoteCall'

import { LOGIN_SUCCESS } from '../login/action'

import { setCurrentUser } from './setCurrentUser/reducer'

const initialState = null

const currentUserReducer = (state = initialState, action) => {
  switch (action.type) {
    case LOGIN_SUCCESS:
      return setCurrentUser(state, action)
    default:
      return state
  }
}

export default currentUserReducer
export { initialState }
