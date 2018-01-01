import styled from 'react-emotion'

// https://github.com/suitcss/suit/blob/master/doc/naming-conventions.md

export default styled('div') `
  .Home--arrow-up {
    width: 0;
    height: 0;
    border-left: 7px solid transparent;
    border-right: 7px solid transparent;
    border-bottom-width: 10px;
    border-bottom-style: solid;
  }

  .Home--arrow-down {
    width: 0;
    height: 0;
    border-left: 7px solid transparent;
    border-right: 7px solid transparent;
    border-top-width: 10px;
    border-top-style: solid;
  }
`
