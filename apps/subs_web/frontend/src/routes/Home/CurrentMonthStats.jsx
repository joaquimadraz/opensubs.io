import React from 'react'
import PropTypes from 'prop-types'
import { Map } from 'immutable'
import { formatDateToMonthYear } from 'utils/dt'

import SubscriptionPill from 'components/SubscriptionPill'
import Styles from './Styles'

const renderYearlySubscriptions = (subscriptions) => {
  const yearlyPayments = subscriptions.filter(sub => sub.cycle === 'yearly')

  const noYearlyPayments = (
    <div>
      <p className="gray f6">No yearly payments this month.</p>
    </div>
  )

  return (
    <div className="flex-auto">
      <div className="f6 b light-silver">
        <span className="subs-pink">Yearly payments</span>
        <small className="ml2">this month</small>
      </div>
      <div className="flex mt2">
        {yearlyPayments.size === 0
          ? noYearlyPayments
          : yearlyPayments.map((subscription, index) => (
            <SubscriptionPill subscription={subscription} last={index !== subscriptions.length} />
          ))}
      </div>
    </div>
  )
}

const CurrentMonthStats = (props) => {
  const { month, prevMonth } = props

  const diff = month.get('total') - prevMonth.get('total')
  const sign = diff > 0 ? '+' : '-'
  const signCx = diff > 0 ? 'red' : 'green'
  const upDown = diff > 0 ? 'up' : 'down'

  return (
    <Styles>
      <h3 className="black-70 f4">{formatDateToMonthYear()}</h3>
      <div className="flex">
        <div className="flex-auto">
          <div className="f6 b light-silver">Total</div>
          <span className="f2 b dib mt2 black-70">
            <span className="v-mid">£{month.get('total')}</span>
            {
              diff !== 0
                ? (
                  <small className={`f5 ${signCx} v-mid ml2`}>
                    <span className={`Home--arrow-${upDown} dib v-mid b--${signCx}`} />
                    <span className="dib ml2 v-mid">{sign} £{Math.abs(diff)}</span>
                  </small>
                )
                : null
            }
          </span>
        </div>
        <div className="flex-auto">
          {renderYearlySubscriptions(month.get('subscriptions'))}
        </div>
      </div>
    </Styles>
  )
}

CurrentMonthStats.propTypes = {
  month: PropTypes.instanceOf(Map).isRequired,
  prevMonth: PropTypes.instanceOf(Map).isRequired,
}

export default CurrentMonthStats
