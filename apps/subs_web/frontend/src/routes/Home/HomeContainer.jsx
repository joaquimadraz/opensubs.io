import React, { Component } from 'react'
import { connect } from 'react-redux'

import Home from './Home'

class HomeContainer extends Component {
  render() {
    const { currentUser } = this.props

    return (
      <Home currentUser={currentUser} />
    )
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(HomeContainer)
