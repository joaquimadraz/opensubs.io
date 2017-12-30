import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'
import classNames from 'classnames'

import routes from 'constants/routes'
import Subscription from 'data/domain/subscriptions/Subscription'
import Styles from './Styles'

const SubscriptionPill = ({ subscription, last }) => {
  return (
    <Styles
      className={classNames('flex-auto bg-black pa2 white mr2 db', { mr2: !last })}
      background={subscription.color}
      textColor={subscription.textColor}
    >
      <Link
        to={routes.subscriptionsShow(subscription.id)}
        className="no-underline"
      >
        <div className="f6">{subscription.name}</div>
        <div className="b mt2">{subscription.amountFormatted}</div>
      </Link>
    </Styles>
  )
}

SubscriptionPill.propTypes = {
  subscription: PropTypes.instanceOf(Subscription).isRequired,
  last: PropTypes.bool,
}

SubscriptionPill.defaultProps = {
  last: false,
}

export default SubscriptionPill
