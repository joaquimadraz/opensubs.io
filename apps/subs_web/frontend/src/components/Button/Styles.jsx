import styled from 'react-emotion'

export default styled('button') `
  background: #EF4370;
  box-shadow: inset 0px -3px 0px 0px #BC274E;
  padding: 11px;
  min-width: 75px;
  border-bottom: 2px solid #EDEDED;

  &:active {
    margin-top: 2px;
    border-bottom: 0;
  }

  &:focus {
    outline: 0;
  }
`
