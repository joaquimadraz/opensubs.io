import styled from 'react-emotion';

export default styled('div') `
  background: ${props => props.background || 'none'};
  padding: 5px;
  margin: 5px 0;

  .amount {
    disaply: inline-block;
    margin-left: 10px;
  }
`
