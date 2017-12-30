import React from 'react'
import { Link } from 'react-router'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'
import SubscriptionListItem from 'components/SubscriptionListItem'
import routes from 'constants/routes'

const renderSubscriptionItem = subscription => (
  <SubscriptionListItem
    key={subscription.id}
    subscription={subscription}
  />
)

const renderNoPayments = () => (
  <p className="b silver tc">
    <span>You have no payments. Click </span>
    <Link to={routes.subscriptionsNew} className="subs-pink">here</Link>
    <span> to add one.</span>
  </p>
)

const renderSubscriptionsList = subscriptions => (
  <div>
    <h3 className="black-70 f5 mb2 mt3">Payments</h3>
    <ul className="pl0 mt0">
      <li className="flex justify-around items-center lh-copy ph0-l light-silver">
        <div className="w-40 pa2 f6 b ">Name</div>
        <div className="w-30 pa2 f6 b tc">Next bill date</div>
        <div className="w-20 pa2 f6 b tc">Alerts</div>
        <div className="w-10 pa2 f6 b tr">Amount</div>
      </li>
      {subscriptions.map(renderSubscriptionItem)}
    </ul>
  </div>
)

const SubscriptionsList = ({ subscriptions }) => {
  return (
    <div
      className="SubscriptionList mb2 list"
    >
      {subscriptions.size === 0
        ? renderNoPayments()
        : renderSubscriptionsList(subscriptions)}
    </div>
  )
}

SubscriptionsList.propTypes = {
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
}

export default SubscriptionsList
