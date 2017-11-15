import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

const Home = ({ currentUser, onLogoutClick }) => (
  <div>
    Home
    {
      currentUser
      ? <div>
          <div className="current-user">{currentUser.email}</div>
          <button onClick={onLogoutClick}>Logout</button>
        </div>
      : <div>
          <Link to={routes.signup}>Sign Up</Link>
          <Link to={routes.login}>Login</Link>
        </div>
    }
  </div>
)

export default Home
