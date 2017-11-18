import React from 'react'
import styled from 'react-emotion';

import Styles from './Styles'

const SubscriptionListItem = ({ subscription }) =>
  <Styles background={subscription.color}>
    {subscription.name}
    <span className="amount">{subscription.amount_currency_symbol}{subscription.amount}</span>
  </Styles>

export default SubscriptionListItem
