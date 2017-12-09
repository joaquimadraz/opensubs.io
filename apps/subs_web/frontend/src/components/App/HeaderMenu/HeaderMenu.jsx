import React from 'react'
import PropTypes from 'prop-types'

import HeaderLink from 'components/HeaderLink'
import Styles from './Styles'

const HeaderMenu = ({
  onLogoutClick,
  onMouseEnter,
  onMouseLeave,
  open,
}) => (
  <Styles
    className="Header--container relative"
    onMouseEnter={onMouseEnter}
    onMouseLeave={onMouseLeave}
    open={open}
  >
    <HeaderLink className="Header--menu-trigger" active={open}>
      My Account
    </HeaderLink>
    <div className="Header--menu">
      <div>
        <HeaderLink className="Header--menu-button bg-near-white b--white">
          Settings
        </HeaderLink>
      </div>
      <div>
        <button
          className="Header--menu-button Header--logout-button bg-near-white pointer b f5 bb br0 b--near-white light-silver no-underline tc dib"
          onClick={onLogoutClick}
        >
          Logout
        </button>
      </div>
    </div>
  </Styles>
)

HeaderMenu.propTypes = {
  onLogoutClick: PropTypes.func.isRequired,
  open: PropTypes.bool,
  onMouseEnter: PropTypes.func,
  onMouseLeave: PropTypes.func,
}

HeaderMenu.defaultProps = {
  open: false,
  onMouseEnter: () => {},
  onMouseLeave: () => {},
}

export default HeaderMenu
