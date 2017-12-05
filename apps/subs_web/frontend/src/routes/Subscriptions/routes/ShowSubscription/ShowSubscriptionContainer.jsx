import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'
import getSubscriptionAction from 'data/domain/subscriptions/getSubscription/action'
import ShowSubscription from './ShowSubscription'

class ShowsSubscriptionContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.state = {
      data: new Subscription(),
    }
  }

  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getSubscriptionAction(1))
  }

  componentWillReceiveProps(nextProps) {
    if (this.state.data.id !== nextProps.subscription.id) {
      this.setState({ data: nextProps.subscription })
    }
  }

  handleFormSubmit() {
    // TODO
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      const data = prevState.data.set(attribute, value)
      return { ...prevState, data }
    })
  }

  render() {
    const { remoteCall } = this.props
    const { data } = this.state

    return (
      <ShowSubscription
        services={OrderedSet()}
        subscription={data}
        remoteCall={remoteCall}
        onClick={this.handleFormSubmit}
        onChange={this.handleFormChange}
      />
    )
  }
}

const mapStateToProps = (state, props) => {
  const { services, subscriptions } = state
  const { params: { subscriptionId } } = props

  const subscription = subscriptions.getIn(['entities', parseInt(subscriptionId, 10)])

  const servicesRecords = services.get('ids').map(id => (
    services.getIn(['entities', id])
  ))

  return {
    subscription,
    services: servicesRecords,
    remoteCall: state.subscriptions.get('remoteCall'),
  }
}

ShowsSubscriptionContainer.propTypes = {
  dispatch: PropTypes.func.isRequired,
  services: PropTypes.instanceOf(OrderedSet),
  remoteCall: PropTypes.instanceOf(RemoteCall),
  subscription: PropTypes.instanceOf(Subscription).isRequired,
}

export default connect(mapStateToProps)(ShowsSubscriptionContainer)
