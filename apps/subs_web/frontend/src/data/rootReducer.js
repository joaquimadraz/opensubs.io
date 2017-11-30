import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import signupReducer from 'data/domain/signupReducer'
import loginReducer from 'data/domain/loginReducer'
import currentUserReduder from 'data/domain/currentUser/currentUserReducer'
import subscriptionsReducer from 'data/domain/subscriptions/subscriptionsReducer'
import servicesReducer from 'data/domain/services/servicesReducer'

const rootReducer = combineReducers({
  routing: routerReducer,
  signup: signupReducer,
  login: loginReducer,
  currentUser: currentUserReduder,
  subscriptions: subscriptionsReducer,
  services: servicesReducer,
})

export default rootReducer
