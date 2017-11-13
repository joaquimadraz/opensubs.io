import React from 'react'

import ErrorMessages from 'components/ErrorMessages'

const renderMessage = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.message) { return null }

  return (<p>{remoteCall.message}</p>)
}

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return <ErrorMessages errors={remoteCall.data.get('errors')} />
}

const RecoverPassword = ({ onClick, onChange, remoteCall }) => {
  return (
    <div id="recover-password-form">
      {renderErrors(remoteCall)}
      {renderMessage(remoteCall)}

      <input
        className="user-email"
        type="email"
        placeholder="email"
        onChange={(event) => onChange(event.target.value)}
      />

      <button id="recover-password-btn" onClick={onClick}>Reset password</button>
    </div>
  )
}

export default RecoverPassword
