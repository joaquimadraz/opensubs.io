import React from 'react'
import PropTypes from 'prop-types'
import { Map } from 'immutable'
import { formatDateToMonthYear, now } from 'utils/dt'

import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Button from 'components/Button'
import SubscriptionsList from 'components/SubscriptionsList'
import CurrentMonthStats from './CurrentMonthStats'
import NextMonthStats from './NextMonthStats'
import Styles from './Styles'

const renderLandingPage = () => {
  return <p>Home</p>
}

const Home = (props) => {
  const {
    currentUser,
    avgs,
    month,
    prevMonth,
    nextMonth,
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
            <CurrentMonthStats month={month} prevMonth={prevMonth} />
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
        <SubscriptionsList subscriptions={month.get('subscriptions')} current />
        <div className="mv4 bb bw2 b--near-white" />
        <NextMonthStats month={month} nextMonth={nextMonth} />
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
  prevMonth: PropTypes.instanceOf(Map).isRequired,
  nextMonth: PropTypes.instanceOf(Map).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default Home
