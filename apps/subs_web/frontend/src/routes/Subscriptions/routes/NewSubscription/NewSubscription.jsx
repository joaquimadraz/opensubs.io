import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'
import routes from 'constants/routes'

import SubscriptionForm from 'components/SubscriptionForm'

const NewSubscription = ({ subscription, onClick, onChange, remoteCall }) => {
  return (
    <div>
      <Link to={routes.root}>Home</Link>

      New subscription

      <SubscriptionForm
        id="new-subscription-form"
        onClick={onClick}
        onChange={onChange}
        remoteCall={remoteCall}
        subscription={subscription}
      />
    </div>
  )
}

NewSubscription.propTypes = {
  subscription: PropTypes.instanceOf(Subscription),
  onClick: PropTypes.func,
  onChange: PropTypes.func,
  remoteCall: PropTypes.instanceOf(RemoteCall),
}

export default NewSubscription
