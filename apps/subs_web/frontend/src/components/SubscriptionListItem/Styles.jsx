import styled from 'react-emotion'

// https://github.com/suitcss/suit/blob/master/doc/naming-conventions.md

export default styled('div') `
  width: 30%;
  background: ${props => props.background || 'none'};
  padding: 5px;
  margin: 5px 0;
  display: flex;

  & > div {
    flex: 1; /*grow*/
  }

  & .SubscriptionListItem--name {
    flex-grow: 3;
  }

  & .SubscriptionListItem--amount {
    flex-grow: 1
  }
`
