import { Record } from 'immutable'

const currentUserObject = {
  name: null,
  email: null,
  auth_token: null,
}

const CurrentUserRecord = Record(currentUserObject)

class CurrentUser extends CurrentUserRecord {
  // Extend immutable js Record
}

export function parseCurrentUser(object) {
  return new CurrentUser(object)
}

export default CurrentUser
