import React from 'react'
import PropTypes from 'prop-types'
import cx from 'classnames'

import StyledButton from './Styles'

const colorClass = color => `bg-${color}`

// TODO: Deconstruct props to <button>
const Button = (props) => {
  const { children, color, className, ...buttonProps } = props
  const classNames = cx(
    className,
    colorClass(color),
    'f6 bn white pointer b br0 bb--silver',
  )

  return (
    <StyledButton
      className={classNames}
      {...buttonProps}
    >
      {children}
    </StyledButton>
  )
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
