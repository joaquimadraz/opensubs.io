import React, { Component } from 'react'
import { connect } from 'react-redux'

import routes from 'constants/routes'

// TODO: Remove duplication
class RedirectIfNotLoggedContainer extends Component {
  componentDidMount() {
    const { currentUser, router } = this.props

    if (!currentUser.isLogged) {
      const pathname = this.props.location.pathname

      router.push(`${routes.login}?r=${pathname}`)
    }
  }

  componentWillReceiveProps(nextProps) {
    const { currentUser, router } = nextProps

    if (!currentUser.isLogged) {
      const pathname = this.props.location.pathname

      router.push(`${routes.login}?r=${pathname}`)
    }
  }

  render() {
    const { currentUser, children } = this.props

    return (currentUser.isLogged) ? children : null
  }
}

const mapStateToProps = (state) => {
  return {
    currentUser: state.currentUser,
  }
}

export default connect(mapStateToProps)(RedirectIfNotLoggedContainer)
