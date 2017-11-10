import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router'

import routes from 'constants/routes'
import signupAction from 'data/domain/signup/action'

class SignupContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)

    this.state = {
      data: {
        email: 'hey',
        password: 'hey',
        password_confirmation: 'hey',
      }
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props

    dispatch(signupAction({user: this.state.data}))
  }

  render() {
    return (
      <div>
        <Link to={routes.root}>Home</Link>
        Signup
        <div>
          <input id="user-email" type="email" placeholder="email" />
          <input id="user-password" type="password" placeholder="password" />
          <input id="user-password-confirmation" type="password" placeholder="password confirmation" />
          <button id="signup-btn" onClick={this.handleFormSubmit}>Let's go!</button>
        </div>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    remoteCall: state.signup['remoteCall'],
  }
}

export default connect(mapStateToProps)(SignupContainer)
