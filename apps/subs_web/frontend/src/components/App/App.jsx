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
      <Link to={routes.signup}>Sign Up</Link>
      <Link to={routes.login}>Login</Link>
    </div>
  )

  return (
    <Styles>
      <div className="bg-near-white">
        <section className="mw8-ns center pa3 ph3-m ph5-ns">
          <div className="mw9 center">
            <div className="cf">
              <div className="fl w-100 w-75-ns">
                <Link to={routes.root} className="f1 mt0 no-underline">Subs</Link>
              </div>
              <div className="fl w-100 w-25-ns tr">
                {currentUser.isLogged ? renderLogged() : renderNotLogged()}
              </div>
            </div>
          </div>
        </section>
      </div>
      <section className="mw8-ns center pa3 ph3-m ph5-ns">
        {children}
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
