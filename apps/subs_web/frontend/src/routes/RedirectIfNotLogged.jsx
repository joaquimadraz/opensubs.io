import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'

class RedirectIfNotLoggedContainer extends Component {
  componentDidMount() {
    const { currentUser, router, location } = this.props

    if (!currentUser.isLogged) {
      router.push(`${routes.login}?r=${location.pathname}`)
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

RedirectIfNotLoggedContainer.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  router: PropTypes.object.isRequired,
  location: PropTypes.object.isRequired,
  children: PropTypes.object.isRequired,
}

export default connect(mapStateToProps)(RedirectIfNotLoggedContainer)
