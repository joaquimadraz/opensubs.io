import React, { Component } from 'react'
import { connect } from 'react-redux'

import logoutAction from 'data/domain/currentUser/logout/action'

import Home from './Home'

class HomeContainer extends Component {
  constructor() {
    super()

    this.handleLogoutClick = this.handleLogoutClick.bind(this)
  }

  handleLogoutClick() {
    const { dispatch } = this.props

    dispatch(logoutAction())
  }

  render() {
    const { currentUser } = this.props

    return (
      <Home
        currentUser={currentUser}
        onLogoutClick={this.handleLogoutClick}
      />
    )
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(HomeContainer)
