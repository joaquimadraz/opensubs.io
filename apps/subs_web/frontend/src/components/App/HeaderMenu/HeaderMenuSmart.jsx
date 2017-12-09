import React, { Component } from 'react'
import PropTypes from 'prop-types'
import HeaderMenu from './HeaderMenu'

class HeaderMenuSmart extends Component {
  constructor() {
    super()

    this.openMenu = this.openMenu.bind(this)
    this.closeMenu = this.closeMenu.bind(this)

    this.state = {
      open: false,
    }
  }

  openMenu() {
    this.setState(() => ({ open: true }))
  }

  closeMenu() {
    this.setState(() => ({ open: false }))
  }

  render() {
    const { onLogoutClick } = this.props

    return (
      <HeaderMenu
        open={this.state.open}
        onMouseEnter={this.openMenu}
        onMouseLeave={this.closeMenu}
        onLogoutClick={onLogoutClick}
      />
    )
  }
}

HeaderMenuSmart.propTypes = {
  onLogoutClick: PropTypes.func.isRequired,
}

export default HeaderMenuSmart
