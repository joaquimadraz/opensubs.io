import React from 'react'
import PropTypes from 'prop-types'

import CurrentUser from 'data/domain/currentUser/CurrentUser'

const Account = ({ currentUser }) => {
  return (
    <div>
      Account {currentUser.email}
    </div>
  )
}

Account.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
}

export default Account
