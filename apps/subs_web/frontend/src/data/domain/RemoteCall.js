import { Record, Map } from 'immutable'

const remoteCallObject = {
  loading: false,
  http: null,
  data: null,
}

const RemoteCallRecord = Record(remoteCallObject)

class RemoteCall extends RemoteCallRecord {
  // Extend immutable js Record
}

export function parseErrorResponse(object) {
  const { data } = object.response
  delete object.response.data

  return new RemoteCall({
    loading: false,
    http: object.response,
    data: Map({
      errors: Map(data.data.errors),
    }),
  })
}

export default RemoteCall
