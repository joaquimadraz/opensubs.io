import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'

class RedirectIfNotLoggedContainer extends Component {
  componentDidMount() {
    const { currentUser, router } = this.props

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

RedirectIfNotLoggedContainer.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  router: PropTypes.object.isRequired,
  children: PropTypes.object.isRequired,
}

export default connect(mapStateToProps)(RedirectIfNotLoggedContainer)
