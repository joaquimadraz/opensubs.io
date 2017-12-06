import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'

import SubscriptionForm from 'components/SubscriptionForm'

const ShowSubscription = ({
  subscription,
  services,
  onClick,
  onChange,
  remoteCall,
}) => {
  if (!subscription) {
    return (<p>Loading...</p>)
  }

  return (
    <div>
      <h1>{subscription.name}</h1>

      <SubscriptionForm
        onClick={onClick}
        onChange={onChange}
        remoteCall={remoteCall}
        subscription={subscription}
        services={services}
      />
    </div>
  )
}

ShowSubscription.propTypes = {
  subscription: PropTypes.instanceOf(Subscription),
  onClick: PropTypes.func,
  onChange: PropTypes.func,
  remoteCall: PropTypes.instanceOf(RemoteCall),
  services: PropTypes.instanceOf(OrderedSet),
}

export default ShowSubscription
