import { Record } from 'immutable'

const currentUserObject = {
  id: null,
  name: null,
  email: null,
}

const CurrentUserRecord = Record(currentUserObject)

class CurrentUser extends CurrentUserRecord {
  // Extend immutable js Record
}

export function parseCurrentUser(object) {
  return new CurrentUser(object)
}

export default CurrentUser
