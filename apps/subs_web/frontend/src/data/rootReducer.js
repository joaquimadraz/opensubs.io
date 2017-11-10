import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import signUpReducer from 'data/domain/signupReducer'

const rootReducer = combineReducers({
  routing: routerReducer,
  signup: signUpReducer,
})

export default rootReducer
