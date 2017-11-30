import { parseService } from 'data/domain/services/Service'
import RemoteCall, { parseErrorResponse } from 'data/domain/RemoteCall'

const resetState = state => state.set('remoteCall', new RemoteCall())

const getAllServicesStarted = (state) => {
  return resetState(state).setIn(['remoteCall', 'loading'], true)
}

const getAllServicesSuccess = (state, { data }) => {
  return data.reduce((result, service) => (
    result.update('ids', value => value.add(service.code))
      .setIn(['entities', service.code], parseService(service))
  ), resetState(state))
}

const getAllServicesFailure = (state, { error }) => {
  return state.set('remoteCall', parseErrorResponse(error))
}

export {
  getAllServicesStarted,
  getAllServicesSuccess,
  getAllServicesFailure,
}
