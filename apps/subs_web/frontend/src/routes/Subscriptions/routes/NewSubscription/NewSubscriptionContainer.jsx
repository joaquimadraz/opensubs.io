import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Map } from 'immutable'

import Subscription from 'data/domain/subscriptions/Subscription'
import createSubscriptionAction from 'data/domain/subscriptions/createSubscription/action'
import NewSubscription from './NewSubscription'

class NewSubscriptionContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.state = {
      data: new Subscription(),
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props
    let data = this.state.data.toMap()

    if (!data.get('service_code')) {
      data = data.delete('service_code')
    }

    dispatch(createSubscriptionAction({ subscription: data }))
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      const data = prevState.data.set(attribute, value)
      return { ...prevState, data }
    })
  }

  render() {
    const { subscription, remoteCall } = this.props
    const { data } = this.state
    const newSubscription = subscription || data

    return (
      <NewSubscription
        subscription={newSubscription}
        remoteCall={remoteCall}
        onClick={this.handleFormSubmit}
        onChange={this.handleFormChange}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const subscription = state.subscriptions.getIn(['entities', 'new'])

  return {
    subscription,
    remoteCall: state.subscriptions.get('remoteCall'),
  }
}


export default connect(mapStateToProps)(NewSubscriptionContainer)
