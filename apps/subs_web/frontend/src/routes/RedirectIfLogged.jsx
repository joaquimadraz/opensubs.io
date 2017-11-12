import React, { Component } from 'react'
import { connect } from 'react-redux'

import routes from 'constants/routes'
import Home from './Home'

class RedirectIfLoggedContainer extends Component {
  componentDidMount() {
    const { dispatch, currentUser, router } = this.props

    if (currentUser) {
      router.push(routes.root)
    }
  }

  componentWillReceiveProps(nextProps) {
    const { dispatch, currentUser, router } = nextProps

    if (currentUser) {
      router.push(routes.root)
    }
  }

  render() {
    const { currentUser, children } = this.props

    return (!currentUser) ? children : null
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(RedirectIfLoggedContainer)
