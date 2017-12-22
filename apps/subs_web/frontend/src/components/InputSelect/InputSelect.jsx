import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Select from 'react-select'

import Styles from './Styles'

const cx = className => classNames(className)

const InputSelect = ({
  className,
  name,
  placeholder,
  value,
  options,
  onChange,
}) => (
  <Styles>
    <Select
      name={name}
      placeholder={placeholder}
      className={cx(className).toString()}
      value={value}
      options={options}
      onChange={onChange}
    />
  </Styles>
)

InputSelect.propTypes = {
  name: PropTypes.string,
  className: PropTypes.string,
  placeholder: PropTypes.string,
  value: PropTypes.string,
  options: PropTypes.array.isRequired,
  onChange: PropTypes.func,
}

InputSelect.defaultProps = {
  name: '',
  className: '',
  placeholder: '',
  value: '',
  onChange: () => {},
}

export default InputSelect
