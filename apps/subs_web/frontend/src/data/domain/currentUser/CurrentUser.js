import { Record } from 'immutable'

const remoteData = {
  name: null,
  email: null,
}

const objectData = {
  authToken: null,
  isLogged: false,
  wasRequested: false,
}

const CurrentUserRecord = Record(Object.assign({}, remoteData, objectData))

class CurrentUser extends CurrentUserRecord {
  // Extend immutable js Record
}

export function parseCurrentUser(remoteData) {
  return new CurrentUser(remoteData)
}

export default CurrentUser
