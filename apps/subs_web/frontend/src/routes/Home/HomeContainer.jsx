import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'
import { connect } from 'react-redux'

import RemoteCall from 'data/domain/RemoteCall'
import CurrentUser from 'data/domain/currentUser/CurrentUser'
import getAllSubscriptionsAction from 'data/domain/subscriptions/getAllSubscriptions/action'
import archiveSubscriptionAction from 'data/domain/subscriptions/archiveSubscription/action'
import Home from './Home'

class HomeContainer extends Component {
  constructor() {
    super()

    this.handleSubscriptionArchiveClick = this.handleSubscriptionArchiveClick.bind(this)
  }

  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getAllSubscriptionsAction())
  }

  handleSubscriptionArchiveClick(subscriptionId) {
    const { dispatch } = this.props

    dispatch(archiveSubscriptionAction(subscriptionId, { archived: true }))
  }

  render() {
    const { currentUser, subscriptions, remoteCall } = this.props

    return (
      <Home
        currentUser={currentUser}
        subscriptions={subscriptions}
        remoteCall={remoteCall}
        onSubscriptionArchiveClick={this.handleSubscriptionArchiveClick}
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

HomeContainer.propTypes = {
  dispatch: PropTypes.func.isRequired,
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default connect(mapStateToProps)(HomeContainer)
