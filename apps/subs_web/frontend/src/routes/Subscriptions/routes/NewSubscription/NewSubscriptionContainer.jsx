import React, { Component } from 'react'
import { connect } from 'react-redux'

import NewSubscription from './NewSubscription'

class NewSubscriptionContainer extends Component {
  constructor() {
    super()
  }

  render() {
    return (
      <NewSubscription />
    )
  }
}


export default connect()(NewSubscriptionContainer)
