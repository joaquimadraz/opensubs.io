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
        {yearlyPayments.length === 0
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
    avgs,
    month,
    remoteCall,
  } = props

  if (remoteCall.loading) {
    return (<p>Loading...</p>)
  }

  const renderLoggedPage = () => {
    return (
      <div>
        <div className="flex">
          <div className="flex-column w-60">
            <h3 className="black-70 f4">January 2018</h3>
            <div className="flex">
              <div className="flex-auto">
                <div className="f6 b light-silver">Total</div>
                <span className="f2 b dib mt2 black-70">
                  <span className="v-mid">{month.get('total')}</span>
                  <small className="f5 red v-mid ml2">
                    <span className="Home--arrow-up dib v-mid red" />
                    <span className="dib ml2 v-mid">+ £350</span>
                  </small>
                </span>
              </div>
              <div className="flex-auto">
                {renderYearlySubscriptions(month.get('subscriptions'))}
              </div>
            </div>
          </div>
          <div className="mh4 br bw2 b--near-white" />
          <div className="flex-column w-40">
            <h3 className="black-70 f4">Average Expenses</h3>
            <div>
              <span className="black-70 f2 b dib">
                <div className="f6 b light-silver">per month</div>
                <span className="f2 b dib mt2 black-70">
                  {avgs.get('monthly')}
                </span>
              </span>
              <span className="black-70 f2 b dib ml4-ns">
                <div className="f6 b light-silver">per year</div>
                <span className="f2 b dib mt2 black-70">
                  {avgs.get('yearly')}
                </span>
              </span>
            </div>
          </div>
        </div>
        <div className="mv4 bb bw2 b--near-white" />
        <SubscriptionsList subscriptions={month.get('subscriptions')} current/>
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
  month: PropTypes.instanceOf(Map).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Home
