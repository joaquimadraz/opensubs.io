import api from 'data/api'

const LOGIN_STARTED = 'LOGIN_STARTED'
const LOGIN_SUCCESS = 'LOGIN_SUCCESS'
const LOGIN_FAILURE = 'LOGIN_FAILURE'

function handleLoginStarted(dispatch) {
  dispatch({ type: LOGIN_STARTED })
}

function handleLoginSuccess(dispatch, response) {
  const { data, meta } = response.data

  dispatch({ type: LOGIN_SUCCESS, data, meta })
}

function handleLoginFailure(dispatch, error) {
  dispatch({ type: LOGIN_FAILURE, error })
}

const login = (email, password) =>
  (dispatch) => {
    handleLoginStarted(dispatch)

    api.postUsersAuthenticate({ email, password })
      .then(response => handleLoginSuccess(dispatch, response))
      .catch(error => handleLoginFailure(dispatch, error))
  }

export default login

export {
  LOGIN_STARTED,
  LOGIN_SUCCESS,
  LOGIN_FAILURE,
}
