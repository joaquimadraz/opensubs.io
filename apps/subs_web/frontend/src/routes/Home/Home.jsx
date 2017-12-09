import React from 'react'
import PropTypes from 'prop-types'

import CurrentUser from 'data/domain/currentUser/CurrentUser'

const renderLandingPage = () => {
  return <p>Home</p>
}

const Home = (props) => {
  const { currentUser } = props

  const renderLoggedPage = () => {
    return (
      <div>
        Logged
      </div>
    )
  }

  return (
    <div>
      {currentUser.isLogged ? renderLoggedPage() : renderLandingPage()}
    </div>
  )
}

Home.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
}

export default Home
