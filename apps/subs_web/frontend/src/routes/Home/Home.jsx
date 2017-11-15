import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

const renderLandingPage = () => {
  return <p>Home</p>
}

const renderLoggedPage = () => {
  return (
    <div>
      <hr />
      <Link to={routes.subscriptionsNew}>Create subscription</Link>
    </div>
  )
}

const Home = ({ currentUser }) => {
  return (
    <div>{currentUser ? renderLoggedPage() : renderLandingPage()}</div>
  )
}

export default Home
