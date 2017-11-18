import React, { Component } from 'react'
import { connect } from 'react-redux'

import getAllSubscriptionsAction from 'data/domain/subscriptions/getAllSubscriptions/action'
import Home from './Home'

class HomeContainer extends Component {
  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getAllSubscriptionsAction())
  }

  render() {
    const { currentUser, subscriptions } = this.props

    return (
      <Home
        currentUser={currentUser}
        subscriptions={subscriptions}
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
    currentUser,
    subscriptions: subscriptionsRecords,
    remoteCall: subscriptions.get('remoteCall'),
  }
}

export default connect(mapStateToProps)(HomeContainer)
