import React, { Component } from 'react'
import { connect } from 'react-redux'

import loginAction from 'data/domain/login/action'
import recoverPasswordAction from 'data/domain/recoverPassword/action'

import Login from './Login'
import RecoverPassword from './RecoverPassword'

const initialLoginData = {
  email: '',
  password: '',
}

class LoginContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.handleRecoverPasswordFormChange = this.handleRecoverPasswordFormChange.bind(this)
    this.handleRecoverFormSubmit = this.handleRecoverFormSubmit.bind(this)

    this.setRecoverPassword = this.setRecoverPassword.bind(this)
    this.setLogin = this.setLogin.bind(this)

    this.state = {
      isLogin: true,
      loginData: initialLoginData,
      recoverEmail: '',
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props
    const { email, password } = this.state.loginData

    dispatch(loginAction(email, password))
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      prevState.loginData[attribute] = value
      return prevState
    })
  }

  handleRecoverPasswordFormChange(email) {
    this.setState(() => ({ recoverEmail: email }))
  }

  handleRecoverFormSubmit() {
    const { dispatch } = this.props
    const { recoverEmail } = this.state

    dispatch(recoverPasswordAction(recoverEmail))
  }

  setRecoverPassword() {
    this.setState(() => ({
      isLogin: false,
      loginData: initialLoginData,
    }))
  }

  setLogin() {
    this.setState(() => ({
      isLogin: true,
      recoverEmail: '',
    }))
  }

  renderLogin() {
    const { remoteCall } = this.props

    return (
      <div>
        <Login
          remoteCall={remoteCall}
          onClick={this.handleFormSubmit}
          onChange={this.handleFormChange}
        />
        <button onClick={this.setRecoverPassword}>Recover password</button>
      </div>
    )
  }

  renderRecoverPassword() {
    const { remoteCall } = this.props

    return (
      <div>
        <RecoverPassword
          remoteCall={remoteCall}
          onChange={this.handleRecoverPasswordFormChange}
          onClick={this.handleRecoverFormSubmit}
        />
        <button onClick={this.setLogin}>Back</button>
      </div>
    )
  }

  render() {
    const { isLogin } = this.state

    return (
      <div>
        {isLogin ? this.renderLogin() : this.renderRecoverPassword()}
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    remoteCall: state.login.get('remoteCall'),
  }
}

export default connect(mapStateToProps)(LoginContainer)
