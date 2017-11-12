import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

const Home = ({ currentUser }) => (
  <div>
    Home
    {
      currentUser
      ? <div className="current-user">{currentUser.email}</div>
      : <div>
          <Link to={routes.signup}>Sign Up</Link>
          <Link to={routes.login}>Login</Link>
        </div>
    }
  </div>
)

export default Home
