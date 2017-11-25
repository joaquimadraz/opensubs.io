import React from 'react'
import PropTypes from 'prop-types'

import Subscription from 'data/domain/subscriptions/Subscription'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription }) => (
  <Styles
    className="flex justify-around items-center br2 lh-copy ph0-l mb2 dim pointer"
    background={subscription.color}
  >
    <div className="w-30 w-60-ns pa2 pa3-ns">
      <span className="SubscriptionListItem--name">
        {subscription.name}
      </span>
    </div>
    <div className="w-30 w-20-ns pa2 pa3-ns">
      <span className="SubscriptionListItem--amount">
        {subscription.amount_currency_symbol}{subscription.amount}
      </span>
    </div>
    <div className="w-40 w-20-ns pa2 pa3-ns tr">
      <span className="SubscriptionListItem--next-bill-date">
        {subscription.humanNextBillDate}
      </span>
    </div>
  </Styles>
)

SubscriptionListItem.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
}

export default SubscriptionListItem
