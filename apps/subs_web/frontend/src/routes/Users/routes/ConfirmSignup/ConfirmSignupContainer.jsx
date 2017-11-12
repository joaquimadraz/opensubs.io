import React, { Component } from 'react'

import api from 'data/api'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'
import routes from 'constants/routes'

class ConfirmSignupContainer extends Component {
  constructor() {
    super()

    this.state = { message: 'Confirming...' }
  }

  componentDidMount() {
    const { location: { query: { t } } } = this.props

    api.postUsersConfirm({ t })
      .then(() => {
        this.setState(() => ({ message: 'Account confirmed, ready to login' }))
      })
      .catch((error) => {
        const remoteCall = parseErrorResponse(error)
        this.setState(() => ({ message: remoteCall.get('message') }))
      })
  }

  render() {
    return (<p>{this.state.message}</p>)
  }
}

export default ConfirmSignupContainer
