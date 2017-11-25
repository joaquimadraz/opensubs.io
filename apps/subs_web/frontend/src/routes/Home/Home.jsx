import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'
import { Link } from 'react-router'

import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'

import ListSubscriptions from './ListSubscriptions'

const renderLandingPage = () => {
  return <p>Home</p>
}

const Home = (props) => {
  const {
    currentUser,
    subscriptions,
    remoteCall,
    onSubscriptionArchiveClick,
  } = props

  const renderLoggedPage = () => {
    return (
      <div>
        <div className="flex bb b--light-gray">
          <h3 className="f4 w-50 pb2">Next payments</h3>
          <div className="w-50 tr mt3 pt2">
            <Link className="f5 no-underline dark-gray dim" to={routes.subscriptionsNew}>New payment</Link>
          </div>
        </div>
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
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

Home.defaultProps = {
  onSubscriptionArchiveClick: () => {},
}

export default Home
