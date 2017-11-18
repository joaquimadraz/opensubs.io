import moment from 'moment'
import 'moment-timezone'

import { dateTimeFormat } from 'constants'

const timezone = 'Europe/London'

const parseFromISO8601 = (dateIso8601) => {
  return moment.utc(dateIso8601).tz(timezone).toDate()
}

const formatDate = (date, format = dateTimeFormat) => {
  return moment(date).format(format)
}

const formatDateToISO8601 = (date) => {
  return moment(date).format()
}

const parseAndFormatDate = (dateIso8601, format = dateTimeFormat) => {
  const date = parseFromISO8601(dateIso8601)
  return formatDate(date, format)
}

export {
  parseFromISO8601,
  formatDate,
  formatDateToISO8601,
  parseAndFormatDate,
}
