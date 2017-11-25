import React from 'react'

import SubscriptionListItem from 'components/SubscriptionListItem'

const renderSubscription = subscription =>
  <SubscriptionListItem
    key={subscription.id}
    subscription={subscription}
  />

const ListSubscriptions = ({ subscriptions, remoteCall }) => {
  return (
    <div>
      <h3 className="f5 mb0 pb2 bb b--light-gray">Next payments</h3>
      <ul className="pl0 mt0">
        <li className="flex justify-around items-center br2 lh-copy ph0-l silver">
          <div className="w-60 pa3 f6">Name</div>
          <div className="w-20 pa3 f6">Amount</div>
          <div className="w-20 pa3 f6 tr">Next bill date</div>
        </li>
        {subscriptions.map(renderSubscription)}
      </ul>
    </div>
  )
}

export default ListSubscriptions
