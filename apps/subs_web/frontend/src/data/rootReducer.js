import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import signupReducer from 'data/domain/signupReducer'
import loginReducer from 'data/domain/loginReducer'

const rootReducer = combineReducers({
  routing: routerReducer,
  signup: signupReducer,
  login: loginReducer,
})

export default rootReducer
