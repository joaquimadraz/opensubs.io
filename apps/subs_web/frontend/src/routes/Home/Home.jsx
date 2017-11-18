import React from 'react'
import { Link } from 'react-router'

import routes from 'constants/routes'

import ListSubscriptions from './ListSubscriptions'

const renderLandingPage = () => {
  return <p>Home</p>
}

const renderLoggedPage = (subscriptions, remoteCall) => {
  return (
    <div>
      <hr />
      <Link to={routes.subscriptionsNew}>Create subscription</Link>
      <hr />
      <ListSubscriptions
        subscriptions={subscriptions}
        remoteCall={remoteCall}
      />
    </div>
  )
}

const Home = ({ currentUser, subscriptions, remoteCall }) => {
  return (
    <div>
      {currentUser.isLogged ? renderLoggedPage(subscriptions) : renderLandingPage()}
    </div>
  )
}

export default Home
