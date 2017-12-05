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
  if (!subscription.id) {
    return (<p>Loading...</p>)
  }

  return (
    <div>
      Subscription

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
