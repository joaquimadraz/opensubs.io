import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'

import Button from 'components/Button'
import SubscriptionForm from 'components/SubscriptionForm'

const ShowSubscription = ({
  data,
  subscription,
  services,
  onClick,
  onChange,
  onArchiveClick,
  remoteCall,
}) => {
  if (!subscription) {
    return (<p>Loading...</p>)
  }

  const handleArchiveClick = (event) => {
    event.preventDefault()

    onArchiveClick(subscription.id)
  }

  return (
    <div>
      <h1>{subscription.name}</h1>

      <SubscriptionForm
        onClick={onClick}
        onChange={onChange}
        remoteCall={remoteCall}
        subscription={data}
        services={services}
      />

      <Button
        className="SubscriptionListItem--archive-button"
        onClick={handleArchiveClick}
      >
        Archive
      </Button>
    </div>
  )
}

ShowSubscription.propTypes = {
  data: PropTypes.instanceOf(Subscription),
  subscription: PropTypes.instanceOf(Subscription),
  onClick: PropTypes.func,
  onChange: PropTypes.func,
  onArchiveClick: PropTypes.func,
  remoteCall: PropTypes.instanceOf(RemoteCall),
  services: PropTypes.instanceOf(OrderedSet),
}

export default ShowSubscription
