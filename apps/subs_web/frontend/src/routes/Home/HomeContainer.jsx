import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { OrderedSet, Map } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import getAllSubscriptionsAction from 'data/domain/subscriptions/getAllSubscriptions/action'

import Home from './Home'

class HomeContainer extends Component {
  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getAllSubscriptionsAction())
  }

  render() {
    const {
      currentUser,
      subscriptions,
      avgs,
      month,
      prevMonth,
      nextMonth,
      remoteCall,
    } = this.props

    return (
      <Home
        avgs={avgs}
        month={month}
        prevMonth={prevMonth}
        nextMonth={nextMonth}
        currentUser={currentUser}
        subscriptions={subscriptions}
        remoteCall={remoteCall}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const { subscriptions, currentUser } = state

  const subscriptionsRecords = subscriptions.get('ids').map(id => (
    subscriptions.getIn(['entities', id])
  ))

  return {
    avgs: subscriptions.get('avgs'),
    month: subscriptions.get('month'),
    prevMonth: subscriptions.get('prevMonth'),
    nextMonth: subscriptions.get('nextMonth'),
    currentUser,
    subscriptions: subscriptionsRecords,
    remoteCall: subscriptions.get('remoteCall'),
  }
}

HomeContainer.propTypes = {
  dispatch: PropTypes.func.isRequired,
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  avgs: PropTypes.instanceOf(Map).isRequired,
  month: PropTypes.instanceOf(Map).isRequired,
  prevMonth: PropTypes.instanceOf(Map).isRequired,
  nextMonth: PropTypes.instanceOf(Map).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default connect(mapStateToProps)(HomeContainer)
