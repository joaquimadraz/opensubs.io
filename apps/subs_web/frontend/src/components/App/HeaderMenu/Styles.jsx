import styled from 'react-emotion'

export default styled('div') `
  width: 125px;
  float: right;

  .Header--menu {
    position: absolute;
    right: 0px;
    top: 48p;
    display: ${props => (props.open ? 'block' : 'none')}
  }
`
