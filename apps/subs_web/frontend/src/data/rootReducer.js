import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import signupReducer from 'data/domain/signupReducer'
import loginReducer from 'data/domain/loginReducer'
import currentUserReduder from 'data/domain/currentUser/currentUserReducer'

const rootReducer = combineReducers({
  routing: routerReducer,
  signup: signupReducer,
  login: loginReducer,
  currentUser: currentUserReduder,
})

export default rootReducer
