import React from 'react'
import PropTypes from 'prop-types'
import cx from 'classnames'

const colorClass = color => `bg-${color}`

// TODO: Deconstruct props to <button>
const Button = props => {
  const { children, color, className, ...buttonProps } = props
  const classNames = cx(
    className,
    colorClass(color),
    'f7 dim bn ph3 pv2 dib white pointer',
  )

  return (<button className={classNames} {...buttonProps}>{children}</button>)
}

Button.propTypes = {
  className: PropTypes.string,
  onClick: PropTypes.func,
  children: PropTypes.any,
  color: PropTypes.string,
}

Button.defaultProps = {
  onClick: () => {},
  color: 'gray',
}

export default Button
