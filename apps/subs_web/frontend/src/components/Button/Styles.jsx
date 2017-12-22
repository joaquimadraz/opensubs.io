import styled from 'react-emotion'

export default styled('button') `
  background: #EF4370;
  padding: 11px;
  min-width: 75px;
  box-shadow: inset 0 0 0 .15rem #BC274E, 0 .15rem 0 0 #E7E6E4;

  &:active {
    margin-top: 2px;
    border-bottom: 0;
    box-shadow: inset 0 0 0 .15rem #BC274E, 0 0 0 0;
  }

  &:focus {
    outline: 0;
  }
`
