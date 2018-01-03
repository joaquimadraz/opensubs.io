import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { OrderedSet, Map } from 'immutable'

import routes from 'constants/routes'
import { now, parseFromISO8601 } from 'utils/dt'
import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import getAllSubscriptionsAction from 'data/domain/subscriptions/getAllSubscriptions/action'

import Home from './Home'

const pad = (num, size) => {
  const s = `0${num}`
  return s.substr(s.length - size)
}

class HomeContainer extends Component {
  constructor() {
    super()

    this.handleNextMonthClick = this.handleNextMonthClick.bind(this)

    this.state = {
      currentDate: null,
    }
  }

  componentWillMount() {
    const { location: { query: { month, year } } } = this.props

    if (month && year) {
      const rawDate = `${year}-${pad(month, 2)}-01T00:00:00Z`
      this.setState(() => ({ currentDate: parseFromISO8601(rawDate) }))
    } else {
      this.setState(() => ({ currentDate: now() }))
    }
  }

  componentDidMount() {
    const { dispatch } = this.props
    const { currentDate } = this.state

    dispatch(getAllSubscriptionsAction({
      month_eq: currentDate.getMonth() + 1,
      year_eq: currentDate.getFullYear(),
    }))
  }

  handleNextMonthClick(date) {
    const { dispatch, router } = this.props

    this.setState(() => ({ currentDate: date }))

    router.push(`${routes.root}?month=${date.getMonth() + 1}&year=${date.getFullYear()}`)

    dispatch(getAllSubscriptionsAction({
      month_eq: date.getMonth() + 1,
      year_eq: date.getFullYear(),
    }))
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

    const { currentDate } = this.state

    return (
      <Home
        currentDate={currentDate}
        avgs={avgs}
        month={month}
        prevMonth={prevMonth}
        nextMonth={nextMonth}
        currentUser={currentUser}
        subscriptions={subscriptions}
        remoteCall={remoteCall}
        onNextMonthClick={this.handleNextMonthClick}
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
  router: PropTypes.object.isRequired,
  dispatch: PropTypes.func.isRequired,
  location: PropTypes.object.isRequired,
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  avgs: PropTypes.instanceOf(Map).isRequired,
  month: PropTypes.instanceOf(Map).isRequired,
  prevMonth: PropTypes.instanceOf(Map).isRequired,
  nextMonth: PropTypes.instanceOf(Map).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default connect(mapStateToProps)(HomeContainer)
