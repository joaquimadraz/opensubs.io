import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import getAllSubscriptionsAction from 'data/domain/subscriptions/getAllSubscriptions/action'
import Subscriptions from './Subscriptions'

class SubscriptionsContainer extends Component {
  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getAllSubscriptionsAction())
  }

  render() {
    const { subscriptions, avgs, remoteCall } = this.props

    return (
      <Subscriptions
        avgs={avgs}
        subscriptions={subscriptions}
        remoteCall={remoteCall}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const { subscriptions } = state

  const subscriptionsRecords = subscriptions.get('ids').map(id => (
    subscriptions.getIn(['entities', id])
  ))

  return {
    avgs: subscriptions.get('avgs'),
    subscriptions: subscriptionsRecords,
    remoteCall: subscriptions.get('remoteCall'),
  }
}

SubscriptionsContainer.propTypes = {
  dispatch: PropTypes.func.isRequired,
  subscriptions: PropTypes.instanceOf(OrderedSet).isRequired,
  remoteCall: PropTypes.instanceOf(RemoteCall).isRequired,
}

export default connect(mapStateToProps)(SubscriptionsContainer)
