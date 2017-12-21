import { Record } from 'immutable'

import colors from 'constants/colors'

const remoteData = {
  name: null,
  code: null,
  color: null,
}

const ServiceRecord = Record(remoteData)

class Service extends ServiceRecord {
  // Extend immutable js Record
  get textColor() {
    return colors.textColorForBg(this.color)
  }
}

export function parseService(data) {
  return new Service(data)
}

export default Service
