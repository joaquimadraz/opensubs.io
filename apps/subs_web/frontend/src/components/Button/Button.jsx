import React from 'react'
import PropTypes from 'prop-types'
import cx from 'classnames'

const colorClass = color => `bg-${color}`

const Button = ({ onClick, children, color }) => (
  <button
    className={cx('f7 dim bn ph3 pv2 dib white pointer', [colorClass(color)])}
    onClick={onClick}
  >
    {children}
  </button>
)

Button.propTypes = {
  onClick: PropTypes.func,
  children: PropTypes.any,
  color: PropTypes.string,
}

Button.defaultProps = {
  onClick: () => {},
  color: 'gray',
}

export default Button
