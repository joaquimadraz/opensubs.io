import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import SubscriptionListItem from 'components/SubscriptionListItem'

const Subscriptions = ({ subscriptions, avgs, remoteCall }) => {
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
    <div>
      <h3 className="black-70 f5">Average Expenses</h3>
      <div>
        <span className="black-70 f2 b dib">{avgs.get('monthly')} <small className="light-silver f5">per month</small></span>
        <span className="black-70 f2 b dib ml4">{avgs.get('yearly')} <small className="light-silver f5">per year</small></span>
      </div>
      <div className="mv4 bb bw2 b--near-white" />
      <h3 className="black-70 f5 mb2 mt3">Payments</h3>
      <ul className="pl0 mt0">
        <li className="flex justify-around items-center lh-copy ph0-l light-silver">
          <div className="w-40 pa2 f6 b ">Name</div>
          <div className="w-30 pa2 f6 b tc">Next bill date</div>
          <div className="w-20 pa2 f6 b tc">Alerts</div>
          <div className="w-10 pa2 f6 b tr">Amount</div>
        </li>
        {subscriptions.map(renderSubscription)}
      </ul>
    </div>
  )
}

Subscriptions.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Subscriptions
