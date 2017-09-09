import Phoenix from 'phoenix_html'
import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { browserHistory, Router, Route, IndexRoute } from 'react-router'
import { syncHistoryWithStore } from 'react-router-redux'

import '../assets/css'
import initStore from './data/store'

import App from './components/App'
import Home from './routes/Home/Home.jsx'

const store = initStore()
const awesomeHistory = syncHistoryWithStore(browserHistory, store)

if (document.getElementById('app')) {
  render(
    <Provider store={store} >
      <Router history={awesomeHistory}>
        <Route path="/" component={App}>
          <IndexRoute component={Home} />
        </Route>
      </Router>
    </Provider>,
    document.getElementById('app'),
  )
}
