import React from 'react'
import { Link } from 'react-router'
import routes from 'constants/routes'

const renderSubscription = subscription => {
  return <p key={subscription.id}>{subscription.name}</p>
}

const ListSubscriptions = ({ subscriptions, remoteCall }) => {
  return (
    <div>
      <h3>Your subscriptions</h3>

      <div>{subscriptions.map(renderSubscription)}</div>
    </div>
  )
}

export default ListSubscriptions
