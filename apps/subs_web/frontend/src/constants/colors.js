const available = [
  { bg: '#F8F8F8', text: '#333333' },
  { bg: '#FF4444', text: '#FFFFFF' },
  { bg: '#1ABC9C', text: '#FFFFFF' },
  { bg: '#2ECC71', text: '#FFFFFF' },
  { bg: '#3498DB', text: '#FFFFFF' },
  { bg: '#34495E', text: '#FFFFFF' },
  { bg: '#D35400', text: '#FFFFFF' },
  { bg: '#95A5A6', text: '#FFFFFF' },
  { bg: '#DB0000', text: '#FFFFFF' },
  { bg: '#000000', text: '#FFFFFF' },
  { bg: '#1ED760', text: '#FFFFFF' },
]

const textColorForBg = available.reduce((acc, color) => {
  acc[color.bg] = color.text
  return acc
}, {})

export default {
  default: available[0].bg,
  available: available.map(color => color.bg),
  textColorForBg,
}
