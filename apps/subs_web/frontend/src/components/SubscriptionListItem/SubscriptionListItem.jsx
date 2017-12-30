import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'

import routes from 'constants/routes'
import Subscription from 'data/domain/subscriptions/Subscription'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription }) => {
  return (
    <Styles
      className="SubscriptionListItem mb2 list"
      background={subscription.color}
      textColor={subscription.textColor}
    >
      <Link
        to={routes.subscriptionsShow(subscription.id)}
        className="flex items-center dim pointer no-underline"
      >
        <div className="w-30 w-40-ns pa2 pa3-ns">
          <span className="SubscriptionListItem--name">
            {subscription.name}
          </span>
        </div>
        <div className="w-30 w-30-ns pa2 pa3-ns tc">
          <span className="SubscriptionListItem--next-bill-date">
            {subscription.humanNextBillDate}
          </span>
        </div>
        <div className="w-10 w-20-ns pa2 pa3-ns tc" />
        <div className="w-30 w-10-ns pa2 pa3-ns tr">
          <span className="SubscriptionListItem--amount">
            {subscription.amountFormatted}
          </span>
        </div>
      </Link>
    </Styles>
  )
}

SubscriptionListItem.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
}

export default SubscriptionListItem
