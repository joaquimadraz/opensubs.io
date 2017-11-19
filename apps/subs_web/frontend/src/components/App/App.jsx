import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'
import Styles from './Styles'

const App = ({ currentUser, onLogoutClick, children }) => {
  const renderLogged = () => (
    <div>
      <div className="current-user">{currentUser.email}</div>
      <button onClick={onLogoutClick}>Logout</button>
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
      <div> {currentUser.isLogged ? renderLogged() : renderNotLogged()}</div>
      {children}
    </Styles>
  )
}

App.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  onLogoutClick: PropTypes.func.isRequired,
  children: PropTypes.object.isRequired,
}

export default App
