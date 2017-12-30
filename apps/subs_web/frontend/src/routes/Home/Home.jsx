import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Button from 'components/Button'
import SubscriptionPill from 'components/SubscriptionPill'
import Styles from './Styles'

const renderLandingPage = () => {
  return <p>Home</p>
}

const renderYearlySubscriptions = (subscriptions) => {
  if (subscriptions.size === 0) { return null }

  const links = subscriptions.map((subscription, index) => (
    <SubscriptionPill subscription={subscription} last={index !== subscriptions.length} />
  ))

  return (
    <div className="flex-auto">
      <div className="f6 b light-silver">
        <span className="subs-pink">Yearly payments</span>
        <small className="ml2">this month</small>
      </div>
      <div className="flex mt2">
        {links}
      </div>
    </div>
  )
}

const renderMonthlySubscriptions = (subscriptions) => {
  if (subscriptions.size === 0) { return null }

  const links = subscriptions.map((subscription, index) => (
    <div className="flex-auto">
      <SubscriptionPill subscription={subscription} last={index !== subscriptions.length} />
      <div className="b orange pa2 f7">in 3 days</div>
    </div >
  ))

  return (
    <div className="flex-auto">
      <div className="f6 b light-silver">Next</div>
      <div className="flex mt2">
        {links}
      </div>
    </div >
  )
}

const Home = (props) => {
  const { currentUser, subscriptions } = props

  const yearlyPayments = subscriptions.filter(sub => sub.cycle === 'yearly')
  const monthlyPayments = subscriptions.filter(sub => sub.cycle === 'monthly')

  const renderLoggedPage = () => {
    return (
      <div>
        <h3 className="black-70 f4">January 2018</h3>
        <div className="flex">
          <div className="flex-auto">
            <div className="f6 b light-silver">Total</div>
            <span className="f2 b dib mt2 black-70">
              <span className="v-mid">£1661</span>
              <small className="f5 red v-mid ml2">
                <span className="Home--arrow-up dib v-mid red" />
                <span className="dib ml2 v-mid">+ £350</span>
              </small>
            </span>
          </div>
          {renderYearlySubscriptions(yearlyPayments)}
          <div className="mh3 br bw2 b--near-white" />
          {renderMonthlySubscriptions(monthlyPayments)}
        </div>
        {/* <h3 className="black-70 f5 mb2 mt3">Payments</h3>
        <ul className="pl0 mt0">
          <li className="flex justify-around items-center lh-copy ph0-l light-silver">
            <div className="w-40 pa2 f6 b ">Name</div>
            <div className="w-30 pa2 f6 b tc">Next bill date</div>
            <div className="w-20 pa2 f6 b tc">Alerts</div>
            <div className="w-10 pa2 f6 b tr">Amount</div>
          </li>
        </ul> */}
        <div className="mv4 bb bw2 b--near-white" />
        <div className="flex silver b">
          <div className="flex-none">
            <div>You will be spending <span className="subs-pink">1300£</span> in January 2018.</div>
            <div>That’s <span className="green">35% less</span> than the previous month.</div>
          </div>
          <div className="flex-none ml3">
            <Button>see more</Button>
          </div>
        </div>
      </div>
    )
  }

  return (
    <Styles>
      {currentUser.isLogged ? renderLoggedPage() : renderLandingPage()}
    </Styles>
  )
}

Home.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
}

export default Home
