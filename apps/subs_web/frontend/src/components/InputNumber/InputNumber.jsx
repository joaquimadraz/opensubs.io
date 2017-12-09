import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const cx = className =>
  classNames(className, 'pa2 gray ba b--black-20')

const InputNumber = ({
  className,
  name,
  placeholder,
  value,
  onChange,
}) => (
  <input
    className={cx(className)}
    type="number"
    placeholder={placeholder}
    value={value}
    onChange={event => onChange(event, name)}
  />
)

InputNumber.propTypes = {
  name: PropTypes.string,
  className: PropTypes.string,
  placeholder: PropTypes.string,
  value: PropTypes.string,
  onChange: PropTypes.func,
}

InputNumber.defaultProps = {
  name: '',
  className: '',
  placeholder: '',
  value: '',
  onChange: () => {},
}

export default InputNumber
