import React from 'react'

import ErrorMessages from 'components/ErrorMessages'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return <ErrorMessages errors={remoteCall.data.get('errors')} />
}

const renderSuccessMessage = (user) => (
  <div>
    <p class="confirmation-message">A confirmation email was sent to {user.get('signed_up_email')}.</p>
    <p>Check your email to confirm your account.</p>
  </div>
)

const Signup = ({ onClick, onChange, user, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  if (user.get('confirmation_sent_at')) {
    return renderSuccessMessage(user)
  }

  return (
    <div>
      Signup

      <div id="signup-form">
        {renderErrors(remoteCall)}
        <input
          className="user-email"
          type="email"
          placeholder="email"
          onChange={(event) => handleChange(event, 'email')}
        />
        <input
          className="user-password"
          type="password"
          placeholder="password"
          onChange={(event) => handleChange(event, 'password')}
        />
        <input
          className="user-password-confirmation"
          type="password"
          placeholder="password confirmation"
          onChange={(event) => handleChange(event, 'password_confirmation')}
        />
        <button id="signup-btn" onClick={onClick}>Let's go!</button>
      </div>
    </div>
  )
}

export default Signup
