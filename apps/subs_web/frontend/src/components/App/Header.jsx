import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router'
import LoadingBar from 'react-redux-loading-bar'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import routes from 'constants/routes'
import HeaderLink from 'components/HeaderLink'

import HeaderMenu from './HeaderMenu'
import Styles from './Styles'

const Header = ({ currentUser, onLogoutClick }) => {
  const renderNotLogged = () => (
    <HeaderLink to={routes.login}>
      Login
    </HeaderLink>
  )

  return (
    <Styles>
      {/* Header */}
      <div className="bb bw2 b--near-white">
        <section className="Header--top-menu mw8-ns center pa3 pb0 ph3-m ph5-ns">
          <div className="ma2 mh0">
            <Link
              to={routes.root}
              className="f1 mt0 no-underline black b tracked-tight v-mid subs-pink-darker"
            >
              Subs
            </Link>
          </div>
          <div className="cf mt4">
            <div className="fl w-100 w-75-ns">
              <HeaderLink to={routes.root} active>
                Up Next
              </HeaderLink>
              <HeaderLink to={routes.root}>
                All Payments
              </HeaderLink>
            </div>
            <div className="fl w-100 w-25-ns tr">
              {currentUser.isLogged
                ? <HeaderMenu onLogoutClick={onLogoutClick} />
                : renderNotLogged()}
            </div>
          </div>
        </section>
      </div>
      <LoadingBar style={{ backgroundColor: '#E35077', marginTop: -4, height: 4 }} />
    </Styles>
  )
}

Header.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  onLogoutClick: PropTypes.func.isRequired,
}

export default Header
