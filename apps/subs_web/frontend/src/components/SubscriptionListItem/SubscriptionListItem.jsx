import React from 'react'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription }) => (
  <Styles background={subscription.color}>
    <span className="subscription-name">{subscription.name}</span>
    <span className="subscription-amount">{subscription.amount_currency_symbol}{subscription.amount}</span>
  </Styles>
)

export default SubscriptionListItem
