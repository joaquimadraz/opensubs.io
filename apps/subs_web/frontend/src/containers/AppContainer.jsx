import React, { Component } from 'react'
import { connect } from 'react-redux'

import getCurrentUserAction from 'data/domain/currentUser/getCurrentUser/action'

class AppContainer extends Component {
  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getCurrentUserAction())
  }

  render() {
    return (
      <div>{this.props.children}</div>
    )
  }
}

export default connect()(AppContainer)
