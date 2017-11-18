import { Record } from 'immutable'

const currentUserObject = {
  name: null,
  email: null,
  authToken: null,
  isLogged: false,
  wasRequested: false,
}

const CurrentUserRecord = Record(currentUserObject)

class CurrentUser extends CurrentUserRecord {
  // Extend immutable js Record
}

export function parseCurrentUser(object) {
  return new CurrentUser(object)
}

export default CurrentUser
