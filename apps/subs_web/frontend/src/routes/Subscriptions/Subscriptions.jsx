import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet, Map } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import SubscriptionsList from 'components/SubscriptionsList'

const Subscriptions = ({ subscriptions, avgs, remoteCall }) => {
  if (remoteCall.loading) {
    return (<p>Loading...</p>)
  }

  return (
    <div>
      <h3 className="black-70 f5">Average Expenses</h3>
      <div>
        <span className="black-70 f2 b dib">{avgs.get('monthly')} <small className="light-silver f5">per month</small></span>
        <span className="black-70 f2 b dib ml4">{avgs.get('yearly')} <small className="light-silver f5">per year</small></span>
      </div>
      <div className="mv4 bb bw2 b--near-white" />
      <SubscriptionsList subscriptions={subscriptions} />
    </div>
  )
}

Subscriptions.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  avgs: PropTypes.instanceOf(Map).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Subscriptions
