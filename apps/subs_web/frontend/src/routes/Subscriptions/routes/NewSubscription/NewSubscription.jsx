import React from 'react'
import { Link } from 'react-router'
import routes from 'constants/routes'
import ErrorMessages from 'components/ErrorMessages'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return <ErrorMessages errors={remoteCall.data.get('errors')} />
}

const NewSubscription = ({ onClick, onChange, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  return (
    <div>
      <Link to={routes.root}>Home</Link>

      New subscription

      <form id="new-subscription-form">
        {renderErrors(remoteCall)}
        <input
          className="subscription-name"
          type="text"
          placeholder="name"
          onChange={(event) => handleChange(event, 'name')}
        />
        <input
          className="subscription-amount"
          type="numeric"
          placeholder="amount"
          onChange={(event) => handleChange(event, 'amount')}
        />
        <select
          className="subscription-amount-currency"
          onChange={(event) => handleChange(event, 'amount_currency')}
        >
          <option value="GBP">£ (GBP)</option>
          <option value="EUR">€ (EUR)</option>
          <option value="USD">$ (USD)</option>
        </select>
        <select
          className="subscription-cycle"
          onChange={(event) => handleChange(event, 'cycle')}
        >
          <option value="monthly">Monthly</option>
          <option value="yearly">Yearly</option>
        </select>
        <button type="submit" onClick={onClick}>Create</button>
      </form>
    </div>
  )
}

export default NewSubscription
