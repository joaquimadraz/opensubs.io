import React from 'react'
import PropTypes from 'prop-types'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'

import SubscriptionForm from 'components/SubscriptionForm'

const NewSubscription = ({ subscription, onClick, onChange, remoteCall }) => {
  return (
    <div>
      New subscription

      <SubscriptionForm
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
