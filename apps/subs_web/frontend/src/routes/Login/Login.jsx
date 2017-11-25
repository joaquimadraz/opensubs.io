import React from 'react'
import { Link } from 'react-router'

import Button from 'components/Button'
import routes from 'constants/routes'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return (<p className="red">{remoteCall.get('message')}</p>)
}

const Login = ({ onClick, onChange, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  return (
    <div id="login-form"className="measure center">
      {renderErrors(remoteCall)}

      <legend className="f4 fw6 ph0 mh0">Login</legend>
      <div className="mt3">
        <span className="db fw6 lh-copy f6">Email</span>
        <input
          className="user-email br2 pa2 input-reset ba w-100"
          type="email"
          placeholder="email"
          onChange={event => handleChange(event, 'email')}
        />
      </div>
      <div className="mv3">
        <span className="db fw6 lh-copy f6">Password</span>
        <input
          className="user-password br2 b pa2 input-reset ba w-100"
          type="password"
          placeholder="password"
          onChange={event => handleChange(event, 'password')}
        />
      </div>
      <div>
        <Button id="login-btn" onClick={onClick}>
          Login
        </Button>
      </div>
      <div className="lh-copy mt3">
        <Link className="f6 link dim black db" to={routes.signup}>Sign Up</Link>
      </div>
    </div>
  )
}

export default Login
