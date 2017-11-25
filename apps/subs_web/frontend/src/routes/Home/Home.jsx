import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'
import { Link } from 'react-router'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'

import ListSubscriptions from './ListSubscriptions'

const renderLandingPage = () => {
  return <p>Home</p>
}

const Home = props => {
  const {
    currentUser,
    subscriptions,
    remoteCall,
    onSubscriptionArchiveClick,
  } = props

  const renderLoggedPage = () => {
    return (
      <div>
        <Link to={routes.subscriptionsNew}>Create subscription</Link>
        <ListSubscriptions
          subscriptions={subscriptions}
          remoteCall={remoteCall}
          onArchiveClick={onSubscriptionArchiveClick}
        />
      </div>
    )
  }

  return (
    <div>
      {currentUser.isLogged ? renderLoggedPage(subscriptions) : renderLandingPage()}
    </div>
  )
}

Home.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  onSubscriptionArchiveClick: PropTypes.func,
}

Home.defaultProps = {
  onSubscriptionArchiveClick: () => {},
}

export default Home
