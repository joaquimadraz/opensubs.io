import React, { Component } from 'react'
import { Map } from 'immutable'
import { connect } from 'react-redux'
import { Link } from 'react-router'

import routes from 'constants/routes'
import signupAction from 'data/domain/signup/action'

import Signup from './Signup'

class SignupContainer extends Component {
  constructor() {
    super()

    this.handleFormSubmit = this.handleFormSubmit.bind(this)
    this.handleFormChange = this.handleFormChange.bind(this)

    this.state = {
      data: {
        email: '',
        password: '',
        password_confirmation: '',
      }
    }
  }

  handleFormSubmit() {
    const { dispatch } = this.props

    dispatch(signupAction({user: this.state.data}))
  }

  handleFormChange(attribute, value) {
    this.setState((prevState) => {
      prevState.data[attribute] = value
      return prevState
    })
  }

  render() {
    const { user, remoteCall } = this.props

    return (
      <Signup
        user={user}
        remoteCall={remoteCall}
        onClick={this.handleFormSubmit}
        onChange={this.handleFormChange}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const user = Map({
    signed_up_email: state.signup.get('signed_up_email'),
    confirmation_sent_at: state.signup.get('confirmation_sent_at'),
  })

  return {
    user,
    remoteCall: state.signup.get('remoteCall'),
  }
}

export default connect(mapStateToProps)(SignupContainer)
