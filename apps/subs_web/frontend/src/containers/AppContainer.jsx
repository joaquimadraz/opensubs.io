import React, { Component } from 'react'
import { connect } from 'react-redux'

import logoutAction from 'data/domain/currentUser/logout/action'
import getCurrentUserAction from 'data/domain/currentUser/getCurrentUser/action'

import App from 'components/App'

class AppContainer extends Component {
  constructor() {
    super()

    this.handleLogoutClick = this.handleLogoutClick.bind(this)
  }

  handleLogoutClick() {
    const { dispatch } = this.props

    dispatch(logoutAction())
  }

  componentDidMount() {
    const { dispatch } = this.props

    dispatch(getCurrentUserAction())
  }

  render() {
    const { currentUser, children } = this.props

    return (
      <App currentUser={currentUser} onLogoutClick={this.handleLogoutClick}>
        {children}
      </App>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(AppContainer)
