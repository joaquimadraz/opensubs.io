import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'

import routes from 'constants/routes'
import Subscription from 'data/domain/subscriptions/Subscription'
import Button from 'components/Button'
import Styles from './Styles'

const SubscriptionListItem = ({ subscription, onArchiveClick }) => {
  const handleArchiveClick = (event) => {
    event.preventDefault()

    onArchiveClick(subscription.id)
  }

  return (
    <Styles
      className="SubscriptionListItem br2 mb2 list"
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
            onClick={handleArchiveClick}
          >
            Archive
          </Button>
        </div>
      </Link>
    </Styles>
  )
}

SubscriptionListItem.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
  onArchiveClick: PropTypes.func,
}

SubscriptionListItem.defaultProps = {
  onArchiveClick: () => {},
}

export default SubscriptionListItem
