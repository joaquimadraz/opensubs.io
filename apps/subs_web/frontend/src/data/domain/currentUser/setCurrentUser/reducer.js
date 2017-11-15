import CurrentUser from 'data/domain/currentUser/CurrentUser'

const setCurrentUser = (state, { data, meta }) => {
  return new CurrentUser(Object.assign({}, data, {
    auth_token: meta.auth_token,
  }))
}

export {
  setCurrentUser,
}
