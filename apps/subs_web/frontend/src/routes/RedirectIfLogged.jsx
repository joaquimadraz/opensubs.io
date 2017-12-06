import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'

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

RedirectIfLoggedContainer.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  router: PropTypes.object.isRequired,
  children: PropTypes.object.isRequired,
}

export default connect(mapStateToProps)(RedirectIfLoggedContainer)
