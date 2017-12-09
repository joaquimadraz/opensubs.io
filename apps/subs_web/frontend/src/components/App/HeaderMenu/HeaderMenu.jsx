import React from 'react'
import PropTypes from 'prop-types'

import HeaderLink from 'components/HeaderLink'

const HeaderMenu = ({
  onLogoutClick,
  open,
  onMouseEnter,
  onMouseLeave,
}) => {
  const style = {
    position: 'absolute',
    right: 0,
    top: 48,
    display: open ? 'block' : 'none',
  }

  return (
    <div
      className="relative"
      onMouseEnter={onMouseEnter}
      onMouseLeave={onMouseLeave}
      style={{ width: 125, float: 'right' }}
    >
      <HeaderLink className="Header--menu-trigger" active={open}>
        My Account
      </HeaderLink>
      <div
        className="Header--menu"
        style={style}
      >
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
    </div>
  )
}

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
