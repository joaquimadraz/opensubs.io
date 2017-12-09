import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const cx = className =>
  classNames(className, 'pa2 gray ba b--black-20')

const InputText = ({
  className,
  name,
  placeholder,
  value,
  onChange,
}) => (
  <input
    className={cx(className)}
    type="text"
    placeholder={placeholder}
    value={value}
    onChange={event => onChange(event, name)}
  />
)

InputText.propTypes = {
  name: PropTypes.string,
  className: PropTypes.string,
  placeholder: PropTypes.string,
  value: PropTypes.string,
  onChange: PropTypes.func,
}

InputText.defaultProps = {
  name: '',
  className: '',
  placeholder: '',
  value: '',
  onChange: () => {},
}

export default InputText
