import api from 'data/api'

const GET_SUBSCRIPTION_STARTED = 'GET_SUBSCRIPTION_STARTED'
const GET_SUBSCRIPTION_SUCCESS = 'GET_SUBSCRIPTION_SUCCESS'
const GET_SUBSCRIPTION_FAILURE = 'GET_SUBSCRIPTION_FAILURE'

function handleGetStarted(dispatch) {
  dispatch({ type: GET_SUBSCRIPTION_STARTED })
}

function handleGetSuccess(dispatch, response) {
  const { data, meta } = response.data

  dispatch({ type: GET_SUBSCRIPTION_SUCCESS, data, meta })
}

function handleGetFailure(dispatch, error) {
  dispatch({ type: GET_SUBSCRIPTION_FAILURE, error })
}

const getAllSubscriptions = (subscriptionId) =>
  (dispatch) => {
    handleGetStarted(dispatch)

    api.getSubscription(subscriptionId)
      .then(response => handleGetSuccess(dispatch, response))
      .catch(error => handleGetFailure(dispatch, error))
  }

export default getAllSubscriptions

export {
  GET_SUBSCRIPTION_STARTED,
  GET_SUBSCRIPTION_SUCCESS,
  GET_SUBSCRIPTION_FAILURE,
}
