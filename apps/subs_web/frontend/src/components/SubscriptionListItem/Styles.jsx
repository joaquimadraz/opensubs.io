import styled from 'react-emotion'

// https://github.com/suitcss/suit/blob/master/doc/naming-conventions.md

export default styled('li') `
  background: ${props => props.background || 'none'};

  & :hover {
    opacity: 0.8;
  }

  div:first-child {
    color: ${props => props.textColor || '#000'};
  }
`
