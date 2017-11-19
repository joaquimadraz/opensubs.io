import styled, { injectGlobal } from 'react-emotion'

// eslint-disable-next-line no-unused-expressions
injectGlobal`
  body {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
  }
`

export default styled('div') `
  width: 1100px;
  margin: 0 auto;
`
