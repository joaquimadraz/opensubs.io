import React from 'react'
import PropTypes from 'prop-types'

const Button = ({ onClick, children }) => (
  <button
    className="f6 dim bn ph3 pv2 dib white bg-red pointer"
    onClick={onClick}
  >
    {children}
  </button>
)

Button.propTypes = {
  onClick: PropTypes.func,
  children: PropTypes.any,
}

Button.defaultProps = {
  onClick: () => {},
}

export default Button
