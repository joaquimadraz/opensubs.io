import Phoenix from 'phoenix_html'
import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { browserHistory, Router, Route, IndexRoute } from 'react-router'
import { syncHistoryWithStore } from 'react-router-redux'
import routes from 'constants/routes'

import '../assets/css'
import initStore from './data/store'
import App from './components/App'
import Home from './routes/Home'
import Signup from './routes/Signup'
import Login from './routes/Login'
import RedirectIfLogged from './routes/RedirectIfLogged'
import UsersConfirmSignup from './routes/Users/routes/ConfirmSignup'
import UsersRecoverPassword from './routes/Users/routes/RecoverPassword'

const store = initStore()
const awesomeHistory = syncHistoryWithStore(browserHistory, store)

if (document.getElementById('app')) {
  render(
    <Provider store={store} >
      <Router history={awesomeHistory}>
        <Route path={routes.root} component={App}>
          <IndexRoute component={Home} />
          <Route component={RedirectIfLogged}>
            <Route path={routes.signup} component={Signup} />
            <Route path={routes.login} component={Login} />
          </Route>
          <Route path={routes.usersConfirmSignup} component={UsersConfirmSignup} />
          <Route path={routes.userRecoverPassword} component={UsersRecoverPassword} />
        </Route>
      </Router>
    </Provider>,
    document.getElementById('app'),
  )
}
