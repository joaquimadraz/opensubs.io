import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import SubscriptionListItem from 'components/SubscriptionListItem'

const ListSubscriptions = ({ subscriptions, remoteCall, onArchiveClick }) => {
  const renderSubscription = subscription =>
    <SubscriptionListItem
      key={subscription.id}
      subscription={subscription}
      onArchiveClick={onArchiveClick}
    />

  return (
    <div>
      <h3 className="f5 mb0 pb2 bb b--light-gray">Next payments</h3>
      <ul className="pl0 mt0">
        <li className="flex justify-around items-center br2 lh-copy ph0-l silver">
          <div className="w-40 pa3 f6">Name</div>
          <div className="w-20 pa3 f6 tc">Amount</div>
          <div className="w-20 pa3 f6 tc">Next bill date</div>
          <div className="w-20 pa3 f6 tr"></div>
        </li>
        {subscriptions.map(renderSubscription)}
      </ul>
    </div>
  )
}

ListSubscriptions.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  onArchiveClick: PropTypes.func.isRequired,
}

export default ListSubscriptions
