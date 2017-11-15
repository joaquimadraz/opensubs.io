import React from 'react'
import { Link } from 'react-router'
import { Map } from 'immutable'

import routes from 'constants/routes'
import ErrorMessages from 'components/ErrorMessages'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return (<p>{remoteCall.get('message')}</p>)
}

const Login = ({ onClick, onChange, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  return (
    <div>
      <Link to={routes.root}>Home</Link>

      <div id="login-form">
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
        <button id="login-btn" onClick={onClick}>Login</button>
      </div>
    </div>
  )
}

export default Login
