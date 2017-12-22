import React from 'react'
import { Link } from 'react-router'

import Button from 'components/Button'
import InputText from 'components/InputText'
import routes from 'constants/routes'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return (<p className="red">{remoteCall.get('message')}</p>)
}

const Login = ({ data, onClick, onChange, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  return (
    <div id="login-form"className="measure center pa3 bg-near-white br2">
      {renderErrors(remoteCall)}

      <legend className="f4 fw6 ph0 mh0 subs-pink-darker">Login</legend>
      <div className="mt3">
        <div className="f5 b dark-gray mb2 mt3">
          Email
        </div>
        <InputText
          className="user-email br2 pa2 input-reset ba w-100"
          type="email"
          placeholder="email"
          value={data.email}
          onChange={event => handleChange(event, 'email')}
        />
      </div>
      <div className="mv3">
        <div className="f5 b dark-gray mb2 mt3">
          Password
        </div>
        <InputText
          className="user-password br2 b pa2 input-reset ba w-100"
          type="password"
          placeholder="password"
          value={data.password}
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
