import styled from 'react-emotion'

export default styled('div') `
  .Select.has-value.Select--single > .Select-control .Select-value .Select-value-label,
  .Select.has-value.is-pseudo-focused.Select--single > .Select-control .Select-value .Select-value-label {
    color: #4A4A4A;
  }

  .Select-control {
    background: rgb(248, 248, 248);
  }

  .Select-clear-zone {
    display: none !important;
  }
`
