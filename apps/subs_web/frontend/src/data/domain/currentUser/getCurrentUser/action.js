import api from 'data/api'

const GET_CURRENT_USER_STARTED = 'GET_CURRENT_USER_STARTED'
const GET_CURRENT_USER_SUCCESS = 'GET_CURRENT_USER_SUCCESS'
const GET_CURRENT_USER_FAILURE = 'GET_CURRENT_USER_FAILURE'

function handleGetStarted(dispatch) {
  dispatch({ type: GET_CURRENT_USER_STARTED })
}

function handleGetSuccess(dispatch, response) {
  const { data, meta } = response.data

  dispatch({ type: GET_CURRENT_USER_SUCCESS, data, meta })
}

function handleGetFailure(dispatch, error) {
  dispatch({ type: GET_CURRENT_USER_FAILURE, error })
}

const getCurrentUser = () =>
  (dispatch) => {
    handleGetStarted(dispatch)

    api.getUsersMe()
      .then(response => handleGetSuccess(dispatch, response))
      .catch(error => handleGetFailure(dispatch, error))
  }

export default getCurrentUser

export {
  GET_CURRENT_USER_STARTED,
  GET_CURRENT_USER_SUCCESS,
  GET_CURRENT_USER_FAILURE,
}
