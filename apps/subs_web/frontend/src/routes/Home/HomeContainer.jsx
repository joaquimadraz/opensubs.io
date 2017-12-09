import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Home from './Home'

class HomeContainer extends Component {
  componentDidMount() {
    // TODO
  }

  render() {
    const { currentUser } = this.props

    return (
      <Home
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

HomeContainer.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
}

export default connect(mapStateToProps)(HomeContainer)
