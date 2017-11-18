import React, { Component } from 'react'
import { connect } from 'react-redux'

import NewSubscription from './NewSubscription'

class NewSubscriptionContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.state = {
      data: {
        name: '',
        amount: '1',
        amount_currency: 'GBP',
        cycle: 'monthly',
      }
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props

    dispatch(signupAction({ subscription: this.state.data }))
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      prevState.data[attribute] = value
      return prevState
    })
  }

  render() {
    const { subscription, remoteCall } = this.props

    return (
      <NewSubscription
        subscription={subscription}
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
