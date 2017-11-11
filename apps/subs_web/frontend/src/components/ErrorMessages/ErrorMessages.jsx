import React from 'react'
import PropTypes from 'prop-types'
import { Map } from 'immutable'

const errorMessages = (errors) => {
  if (errors.size === 0) { return [] }

  return errors.reduce((messages, errorsList, attribute) => {
    const inlineErrors = errorsList.join(', ')

    messages.push(`${attribute}: ${inlineErrors}`)
    return messages
  }, [])
}

const ErrorMessages = ({ errors }) => {
  const messageList = errorMessages(errors)

  return (
    <div>
      <h4>Something went wrong</h4>
      <ul>
        {messageList.map(message => <li>{message}</li>)}
      </ul>
    </div>
  )
}

ErrorMessages.propTypes = {
  errors: PropTypes.instanceOf(Map).isRequired,
}

export default ErrorMessages
