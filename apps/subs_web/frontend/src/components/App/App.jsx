import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'
import Button from 'components/Button'
import Styles from './Styles'

const App = ({ currentUser, onLogoutClick, children }) => {
  const renderLogged = () => (
    <div>
      <div className="current-user">{currentUser.email}</div>
      <Button onClick={onLogoutClick} color="red">Logout</Button>
    </div>
  )

  const renderNotLogged = () => (
    <div>
      <Link to={routes.login}>Login</Link>
    </div>
  )

  return (
    <Styles>
      {/* Header */}
      <div className="bg-near-white">
        <section className="mw8-ns center pa3 ph3-m ph5-ns">
          <div className="mw9 center">
            <div className="cf">
              <div className="fl w-100 w-75-ns">
                <span className="logo dib v-mid" />
                <Link
                  to={routes.root}
                  className="App--logo-title f1 mt0 no-underline black b-ns tracked-tight v-mid ml5 dark-gray"
                >
                  Subs
                </Link>
              </div>
              <div className="fl w-100 w-25-ns tr">
                {currentUser.isLogged ? renderLogged() : renderNotLogged()}
              </div>
            </div>
          </div>
        </section>
      </div>
      {/* Main */}
      <section className="mw8-ns center pa3 ph3-m ph5-ns">
        {children}
      </section>
      {/* Footer */}
      <section className="mw8-ns center pa3 ph3-m ph5-ns">
        <div className="tc">
          <div className="f6">Logo made by <a className="no-underline navy f6" href="https://www.flaticon.com/authors/twitter" title="Twitter">Twitter</a> from <a className="no-underline dark-gray f6" href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a className="no-underline dark-gray f6" href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
        </div>
      </section>
    </Styles>
  )
}

App.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  onLogoutClick: PropTypes.func.isRequired,
  children: PropTypes.object.isRequired,
}

export default App
