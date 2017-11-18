import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

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
    <div>
      <div> {currentUser.isLogged  ? renderLogged() : renderNotLogged()}</div>
      {children}
    </div>
  )
}

export default App
