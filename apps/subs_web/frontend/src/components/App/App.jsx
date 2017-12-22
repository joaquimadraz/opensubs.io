import React from 'react'
import PropTypes from 'prop-types'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Styles from './Styles'
import Header from './Header'

const App = ({ currentUser, onLogoutClick, children }) => {
  return (
    <Styles>
      <Header currentUser={currentUser} onLogoutClick={onLogoutClick} />
      {/* Main */}
      <section className="mw8-ns center pa4">
        {children}
      </section>
    </Styles>
  )
}

App.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
  onLogoutClick: PropTypes.func.isRequired,
  children: PropTypes.object.isRequired,
}

export default App
