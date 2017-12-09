import React from 'react'
import PropTypes from 'prop-types'
import { OrderedSet } from 'immutable'

import RemoteCall from 'data/domain/RemoteCall'
import Subscription from 'data/domain/subscriptions/Subscription'
import colors from 'constants/colors'

import ErrorMessages from 'components/ErrorMessages'
import ColorPicker from 'components/ColorPicker'
import DatePicker from 'components/DatePicker'
import ServiceSelector from 'components/ServiceSelector'
import Button from 'components/Button'
import InputText from 'components/InputText'
import InputNumber from 'components/InputNumber'

const renderErrors = (remoteCall) => {
  if (remoteCall.loading || !remoteCall.data) { return null }

  return <ErrorMessages errors={remoteCall.data.get('errors')} />
}

const buildServiceOptions = (services) => {
  const servicesOptions = services.map(service => ({
    value: service.code,
    color: service.color,
    label: service.name,
  })).toJS()

  servicesOptions.push({
    value: 'custom',
    color: colors.default,
    label: 'Custom',
  })

  return servicesOptions
}

const SubscriptionForm = ({ subscription, services, onClick, onChange, remoteCall }) => {
  const handleChange = (event, attribute) => {
    onChange(attribute, event.target.value)
  }

  const handleServiceChange = (option) => {
    onChange('color', option.color)
    onChange('service_code', (option.value === 'custom' ? null : option.value))
  }

  const servicesOptions = buildServiceOptions(services)

  return (
    <div
      id="subscription-form"
      className="w-40"
    >
      <div className="pa3" style={{ background: subscription.color }}>
        {renderErrors(remoteCall)}
        <div className="f5 b dark-gray mb2">What’s the payment about?</div>
        {!subscription.id &&
          <ServiceSelector
            className="subscription-service w-50"
            value={subscription.service_code || 'custom'}
            options={servicesOptions}
            onChange={handleServiceChange}
          />
        }
        {!subscription.service_code &&
          <InputText
            name="name"
            placeholder="Name"
            className="subscription-name mt2 w-100"
            value={subscription.name}
            onChange={event => handleChange(event, 'name')}
          />}
        <div className="f5 b dark-gray mb2 mt3">Amount</div>
        <div>
          <select
            style={{ height: 35 }}
            className="subscription-amount-currency"
            onChange={event => handleChange(event, 'amount_currency')}
            value={subscription.amount_currency}
          >
            <option value="GBP">£</option>
            <option value="EUR">€</option>
            <option value="USD">$</option>
          </select>
          <InputNumber
            name="amount"
            className="subscription-amount w-30"
            value={subscription.amount}
            onChange={event => handleChange(event, 'amount')}
          />
          <select
            style={{ height: 35 }}
            className="subscription-cycle"
            onChange={event => handleChange(event, 'cycle')}
            value={subscription.cycle}
          >
            <option value="monthly">Monthly</option>
            <option value="yearly">Yearly</option>
          </select>
        </div>
        <div className="f5 b dark-gray mb2 mt3">First bill</div>
        <DatePicker
          value={subscription.first_bill_date}
          onChange={date => onChange('first_bill_date', date)}
        />
        {!subscription.service_code &&
          <div>
            <div className="f5 b dark-gray mb2 mt3">Colors</div>
            <ColorPicker onChange={color => onChange('color', color)} />
          </div>}
      </div>
      <div className="pa3">
        <Button type="submit" onClick={onClick}>Save</Button>
      </div>
    </div>
  )
}

SubscriptionForm.propTypes = {
  subscription: PropTypes.instanceOf(Subscription),
  services: PropTypes.instanceOf(OrderedSet),
  onClick: PropTypes.func,
  onChange: PropTypes.func,
  remoteCall: PropTypes.instanceOf(RemoteCall),
}

SubscriptionForm.defaultProps = {
  services: OrderedSet(),
}

export default SubscriptionForm
