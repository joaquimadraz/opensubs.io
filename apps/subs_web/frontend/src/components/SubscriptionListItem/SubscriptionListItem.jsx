import React from 'react'
import PropTypes from 'prop-types'

import Subscription from 'data/domain/subscriptions/Subscription'
import Button from 'components/Button'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription, onArchiveClick }) => (
  <Styles
    className="SubscriptionListItem flex justify-around items-center br2 lh-copy ph0-l mb2 dim pointer"
    background={subscription.color}
  >
    <div className="w-30 w-40-ns pa2 pa3-ns">
      <span className="SubscriptionListItem--name">
        {subscription.name}
      </span>
    </div>
    <div className="w-30 w-20-ns pa2 pa3-ns tc">
      <span className="SubscriptionListItem--amount">
        {subscription.amount_currency_symbol}{subscription.amount}
      </span>
    </div>
    <div className="w-30 w-20-ns pa2 pa3-ns tc">
      <span className="SubscriptionListItem--next-bill-date">
        {subscription.humanNextBillDate}
      </span>
    </div>
    <div className="w-10 w-20-ns pa2 pa3-ns tr">
      <Button
        className="SubscriptionListItem--archive-button"
        onClick={() => onArchiveClick(subscription.id)}
      >
        Archive
      </Button>
    </div>
  </Styles>
)

SubscriptionListItem.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
  onArchiveClick: PropTypes.func,
}

SubscriptionListItem.defaultProps = {
  onArchiveClick: () => {},
}

export default SubscriptionListItem
