import React from 'react'
import { Link } from 'react-router'
import routes from 'constants/routes'

import SubscriptionListItem from 'components/SubscriptionListItem'

const renderSubscription = subscription =>
  <SubscriptionListItem
    key={subscription.id}
    subscription={subscription}
  />

const ListSubscriptions = ({ subscriptions, remoteCall }) => {
  return (
    <div>
      <h3>Your subscriptions</h3>

      <div>{subscriptions.map(renderSubscription)}</div>
    </div>
  )
}

export default ListSubscriptions
