import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import SubscriptionListItem from 'components/SubscriptionListItem'

const Subscriptions = ({ subscriptions, remoteCall }) => {
  if (remoteCall.loading) {
    return (<p>Loading...</p>)
  }

  const renderSubscription = subscription => (
    <SubscriptionListItem
      key={subscription.id}
      subscription={subscription}
    />
  )

  return (
    <ul className="pl0 mt0">
      <li className="flex justify-around items-center br2 lh-copy ph0-l silver">
        <div className="w-40 pa3 f6">Name</div>
        <div className="w-20 pa3 f6 tc">Amount</div>
        <div className="w-20 pa3 f6 tc">Next bill date</div>
        <div className="w-20 pa3 f6 tr" />
      </li>
      {subscriptions.map(renderSubscription)}
    </ul>
  )
}

Subscriptions.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Subscriptions
