import styled from 'react-emotion'

export default styled('span') `
  background: ${props => props.background || 'none'};
  box-shadow: inset 0px -3px 0px 0px rgba(0,0,0,0.1);

  a {
    color: ${props => props.textColor || '#000'};
  }
`
