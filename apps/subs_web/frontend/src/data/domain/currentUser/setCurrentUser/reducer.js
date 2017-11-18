import CurrentUser from 'data/domain/currentUser/CurrentUser'

const setCurrentUser = (state, { data, meta }) => {
  return new CurrentUser(Object.assign({}, data, {
    authToken: meta.auth_token,
    wasRequested: true,
    isLogged: true,
  }))
}

export {
  setCurrentUser,
}
