import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Link } from 'react-router'

import Styles from './Styles'

const HeaderLink = ({
  to,
  children,
  active,
  className,
}) => {
  const defaultCx = 'b f5 bb b--near-white light-silver no-underline tc dib'
  const cx = classNames(className, defaultCx, { active })

  return (
    <Styles>
      <Link to={to} className={cx}>{children}</Link>
    </Styles>
  )
}

HeaderLink.propTypes = {
  to: PropTypes.string,
  children: PropTypes.string,
  active: PropTypes.bool,
  className: PropTypes.string,
}

HeaderLink.defaultProps = {
  to: '',
  children: '',
  active: false,
}

export default HeaderLink
