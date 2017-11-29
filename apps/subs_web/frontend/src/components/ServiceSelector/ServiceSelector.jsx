import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Select from 'react-select'
import 'react-select/dist/react-select.css'

import colors from 'constants/colors'

class SelectorOption extends Component {
  constructor() {
    super()

    this.handleMouseDown = this.handleMouseDown.bind(this)
    this.handleMouseEnter = this.handleMouseEnter.bind(this)
    this.handleMouseMove = this.handleMouseMove.bind(this)
  }

  handleMouseDown(event) {
    const { onSelect, option } = this.props

    event.preventDefault()
    event.stopPropagation()

    onSelect(option, event)
  }

  handleMouseEnter(event) {
    const { onFocus, option } = this.props

    onFocus(option, event)
  }

  handleMouseMove(event) {
    const { onFocus, option } = this.props

    onFocus(option, event)
  }

  render() {
    const { className, option, children } = this.props

    const style = {
      background: option.color,
      color: colors.textColorForBg[option.color]
    }

    return (
      <div
        className={className}
        onMouseDown={this.handleMouseDown}
        onMouseEnter={this.handleMouseEnter}
        onMouseMove={this.handleMouseMove}
        title={option.label}
        style={style}
      >
        {children}
      </div>
    )
  }
}

SelectorOption.propTypes = {
  option: PropTypes.object.isRequired,
  onFocus: PropTypes.func,
  onSelect: PropTypes.func,
  className: PropTypes.string,
  children: PropTypes.string.isRequired,
}

SelectorOption.defaultProps = {
  onFocus: () => {},
  onSelect: () => { },
}

const SelectorValue = ({ value, children }) => (
  <div
    className="Select-value"
    title={value.value}
    style={{ background: value.color }}
  >
    <span className="Select-value-label" style={{ color: colors.textColorForBg[value.color] }}>
      {children}
    </span>
  </div>
)

SelectorValue.propTypes = {
  value: PropTypes.object.isRequired,
  children: PropTypes.string.isRequired,
}

SelectorValue.defaultProps = {
  onFocus: () => { },
  onSelect: () => { },
}

const ServiceSelector = ({ value, onChange }) => (
  <Select
    options={[
      { value: 'netflix', color: '#DB0000', label: 'Netflix' },
      { value: 'spotify', color: '#1ED760', label: 'Spotify' },
      { value: 'github', color: '#000000', label: 'Github' },
      { value: 'custom', color: '#E2E2E2', label: 'Custom' },
    ]}
    value={value}
    onChange={option => onChange(option)}
    optionComponent={SelectorOption}
    valueComponent={SelectorValue}
  />
)

ServiceSelector.propTypes = {
  value: PropTypes.string,
  onChange: PropTypes.func,
}

ServiceSelector.defaultProps = {
  value: 'custom',
  onChange: () => {},
}

export default ServiceSelector
