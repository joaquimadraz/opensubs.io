import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

const Home = () => (
  <div>
    Home
    <Link to={routes.signup}>Sign Up</Link>
    <Link to={routes.login}>Login</Link>
  </div>
)

export default Home
