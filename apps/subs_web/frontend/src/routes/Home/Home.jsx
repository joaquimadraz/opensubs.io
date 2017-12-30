import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet, Map } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Button from 'components/Button'
import SubscriptionsList from 'components/SubscriptionsList'
import SubscriptionPill from 'components/SubscriptionPill'
import Styles from './Styles'

const renderLandingPage = () => {
  return <p>Home</p>
}

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

const Home = (props) => {
  const {
    currentUser,
    subscriptions,
    avgs,
    remoteCall,
  } = props

  // if (remoteCall.loading) {
  //   return (<p>Loading...</p>)
  // }

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
          {renderYearlySubscriptions(subscriptions)}
        </div>
        <div className="mv4 bb bw2 b--near-white" />
        <h3 className="black-70 f5">Average Expenses</h3>
        <div>
          <span className="black-70 f2 b dib">{avgs.get('monthly')} <small className="light-silver f5">per month</small></span>
          <span className="black-70 f2 b dib ml4">{avgs.get('yearly')} <small className="light-silver f5">per year</small></span>
        </div>
        <div className="mv4 bb bw2 b--near-white" />
        <SubscriptionsList subscriptions={subscriptions} />
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
  avgs: PropTypes.instanceOf(Map).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Home
