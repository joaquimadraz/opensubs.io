import CurrentUser from 'data/domain/currentUser/CurrentUser'

const setCurrentUser = (state, { data }) => {
  return new CurrentUser(data)
}

export {
  setCurrentUser,
}
