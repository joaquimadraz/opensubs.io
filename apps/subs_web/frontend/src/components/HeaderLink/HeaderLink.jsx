import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Link, IndexLink } from 'react-router'

import Styles from './Styles'

const HeaderLink = ({
  to,
  children,
  active,
  className,
  index,
}) => {
  const defaultCx = 'b f5 bb b--near-white light-silver no-underline tc dib'
  const cx = classNames(className, defaultCx, { active })

  return (
    <Styles>
      {index
        ? <IndexLink to={to} className={cx} activeClassName="active">{children}</IndexLink>
        : <Link to={to} className={cx} activeClassName="active">{children}</Link>}
    </Styles>
  )
}

HeaderLink.propTypes = {
  to: PropTypes.string,
  children: PropTypes.string,
  active: PropTypes.bool,
  index: PropTypes.bool,
  className: PropTypes.string,
}

HeaderLink.defaultProps = {
  to: '',
  children: '',
  active: false,
  index: false,
}

export default HeaderLink
