import styled from 'react-emotion'

// https://github.com/suitcss/suit/blob/master/doc/naming-conventions.md

export default styled('li') `
  background: ${props => props.background || 'none'};
  box-shadow: inset 0px -3px 0px 0px rgba(0,0,0,0.1);

  a {
    color: ${props => props.textColor || '#000'};
  }
`
