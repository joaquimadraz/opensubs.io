import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import SubscriptionsList from 'components/SubscriptionsList'

const Subscriptions = ({ subscriptions, remoteCall }) => {
  if (remoteCall.loading) {
    return (<p>Loading...</p>)
  }

  return (
    <SubscriptionsList subscriptions={subscriptions} />
  )
}

Subscriptions.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Subscriptions
