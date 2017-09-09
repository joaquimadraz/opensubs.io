import { createStore, applyMiddleware, compose } from 'redux'
import thunkMiddleware from 'redux-thunk'
import { routerMiddleware } from 'react-router-redux'
import { browserHistory } from 'react-router'
import rootReducer from './rootReducer'

import initialState from './initialState'

// For Redux Devtools:
// https://github.com/zalmoxisus/redux-devtools-extension#12-advanced-store-setup
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const initStore = () => createStore(
  rootReducer,
  initialState,
  composeEnhancers(
    applyMiddleware(
      thunkMiddleware,
      routerMiddleware(browserHistory),
    ),
  )
)

export default initStore
