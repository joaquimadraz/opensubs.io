import React, { Component } from 'react'
import { connect } from 'react-redux'

import loginAction from 'data/domain/login/action'

import Login from './Login'

class LoginContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.state = {
      data: {
        email: '',
        password: '',
      }
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props
    const { email, password } = this.state.data

    dispatch(loginAction(email, password))
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      prevState.data[attribute] = value
      return prevState
    })
  }

  render() {
    const { remoteCall, justConfirmed } = this.props

    return (
      <Login
        justConfirmed={justConfirmed}
        remoteCall={remoteCall}
        onClick={this.handleFormSubmit}
        onChange={this.handleFormChange}
      />
    )
  }
}

const mapStateToProps = (state) => {
  return {
    justConfirmed: state.login.get('justConfirmed'),
    remoteCall: state.login.get('remoteCall'),
  }
}

export default connect(mapStateToProps)(LoginContainer)
