import React from 'react'
import PropTypes from 'prop-types'

import Subscription from 'data/domain/subscriptions/Subscription'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription }) => (
  <Styles background={subscription.color}>
    <div className="SubscriptionListItem--name">{subscription.name}</div>
    <div className="SubscriptionListItem--amount">{subscription.amount_currency_symbol}{subscription.amount}</div>
    <div className="SubscriptionListItem--next-bill-date">{subscription.humanNextBillDate}</div>
  </Styles>
)

SubscriptionListItem.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
}

export default SubscriptionListItem
