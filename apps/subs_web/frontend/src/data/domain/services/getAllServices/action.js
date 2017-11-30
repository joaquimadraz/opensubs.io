import api from 'data/api'

const GET_ALL_SERVICES_STARTED = 'GET_ALL_SERVICES_STARTED'
const GET_ALL_SERVICES_SUCCESS = 'GET_ALL_SERVICES_SUCCESS'
const GET_ALL_SERVICES_FAILURE = 'GET_ALL_SERVICES_FAILURE'

function handleGetStarted(dispatch) {
  dispatch({ type: GET_ALL_SERVICES_STARTED })
}

function handleGetSuccess(dispatch, response) {
  const { data, meta } = response.data

  dispatch({ type: GET_ALL_SERVICES_SUCCESS, data, meta })
}

function handleGetFailure(dispatch, error) {
  dispatch({ type: GET_ALL_SERVICES_FAILURE, error })
}

const getAllServices = () =>
  (dispatch) => {
    handleGetStarted(dispatch)

    api.getServices()
      .then(response => handleGetSuccess(dispatch, response))
      .catch(error => handleGetFailure(dispatch, error))
  }

export default getAllServices

export {
  GET_ALL_SERVICES_STARTED,
  GET_ALL_SERVICES_SUCCESS,
  GET_ALL_SERVICES_FAILURE,
}
