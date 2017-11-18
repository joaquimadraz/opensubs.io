import React, { Component } from 'react'
import { connect } from 'react-redux'

import routes from 'constants/routes'

// TODO: Remove duplication
class RedirectIfLoggedContainer extends Component {
  componentDidMount() {
    const { currentUser, router } = this.props

    if (currentUser.isLogged) {
      router.push(routes.root)
    }
  }

  componentWillReceiveProps(nextProps) {
    const { currentUser, router } = nextProps

    if (currentUser.isLogged) {
      router.push(routes.root)
    }
  }

  render() {
    const { currentUser, children } = this.props

    return (!currentUser.isLogged) ? children : null
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(RedirectIfLoggedContainer)
