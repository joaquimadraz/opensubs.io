import React from 'react'
import { GithubPicker } from 'react-color'
import colors from 'constants/colors'

const ColorPicker = ({ value, onChange }) => {
  const handleChange = color => onChange(color.hex)

  const color = value || colors.default

  return (
    <div>
      <GithubPicker
        triangle='hide'
        color={color}
        colors={colors.available}
        onChangeComplete={handleChange}
      />
    </div>
  )
}

export default ColorPicker
