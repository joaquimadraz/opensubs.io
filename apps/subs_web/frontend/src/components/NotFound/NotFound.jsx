import React from 'react'
import { Link } from 'react-router'
import routes from 'constants/routes'

const NotFound = () =>
  <div>
    <h3>404 page not found</h3>
    <p>We are sorry but the page you are looking for does not exist.</p>
    <p>Go back <Link to={routes.root}>Home</Link></p>
  </div>

export default NotFound
