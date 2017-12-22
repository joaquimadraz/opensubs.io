import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Account from './Account'

class AccountContainer extends Component {
  componentDidMount() {
    // TODO
  }

  render() {
    const { currentUser } = this.props

    return (
      <Account
        currentUser={currentUser}
      />
    )
  }
}

const mapStateToProps = (state) => {
  const { currentUser } = state

  return {
    currentUser,
  }
}

AccountContainer.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
}

export default connect(mapStateToProps)(AccountContainer)
