const defaultColor = { bg: '#F2F2F2', text: '#333333' }
const disabled = { bg: '#F8F8F8', text: '#D0D0D0' }

const available = [
  { bg: '#ED5564', text: '#FFFFFF' },
  { bg: '#D8434E', text: '#FFFFFF' },
  { bg: '#ED5F55', text: '#FFFFFF' },
  { bg: '#D84C42', text: '#FFFFFF' },
  { bg: '#F87E51', text: '#FFFFFF' },
  { bg: '#E7663F', text: '#FFFFFF' },
  { bg: '#FBB254', text: '#FFFFFF' },
  { bg: '#F59B43', text: '#FFFFFF' },
  { bg: '#FCCE54', text: '#FFFFFF' },
  { bg: '#F5BA42', text: '#FFFFFF' },
  { bg: '#C2D468', text: '#FFFFFF' },
  { bg: '#B0C151', text: '#FFFFFF' },
  { bg: '#7277D5', text: '#FFFFFF' },
  { bg: '#9398EC', text: '#FFFFFF' },
  { bg: '#4D8BDC', text: '#FFFFFF' },
  { bg: '#5C9DED', text: '#FFFFFF' },
  { bg: '#3BB0D9', text: '#FFFFFF' },
  { bg: '#4FC2E7', text: '#FFFFFF' },
  { bg: '#30BDAD', text: '#FFFFFF' },
  { bg: '#49CEC1', text: '#FFFFFF' },
  { bg: '#3BB75D', text: '#FFFFFF' },
  { bg: '#43CB6F', text: '#FFFFFF' },
  { bg: '#82C250', text: '#FFFFFF' },
  { bg: '#99D468', text: '#FFFFFF' },
  { bg: '#CB93EE', text: '#FFFFFF' },
  { bg: '#B377D9', text: '#FFFFFF' },
  { bg: '#EC88C0', text: '#FFFFFF' },
  { bg: '#D870AD', text: '#FFFFFF' },
  defaultColor,
  { bg: '#E0E4E7', text: '#333333' },
  { bg: '#C5CBD4', text: '#333333' },
  { bg: '#A5ADB8', text: '#333333' },
  { bg: '#9B9B9B', text: '#FFFFFF' },
  { bg: '#5A595A', text: '#FFFFFF' },
  { bg: '#4A4A4A', text: '#FFFFFF' },
  { bg: '#000000', text: '#FFFFFF' },
]

const textColorForBg = available.reduce((acc, color) => {
  acc[color.bg.toUpperCase()] = color.text
  return acc
}, {})

export default {
  default: defaultColor.bg,
  disabled,
  available: available.map(color => color.bg),
  textColorForBg: color => (textColorForBg[color.toUpperCase()] || '#FFFFFF'),
}
