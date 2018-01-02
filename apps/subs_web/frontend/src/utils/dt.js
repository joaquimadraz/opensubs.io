import moment from 'moment'
import 'moment-timezone'

import { dateTimeFormat, monthYearFormat } from 'constants'

const timezone = 'Europe/London'

const now = () => {
  return moment.utc().tz(timezone).toDate()
}

const addMonths = (date, count) => {
  return moment(date).add(count, 'months').toDate()
}

const toMoment = (dateIso8601) => {
  return moment.utc(dateIso8601).tz(timezone)
}

const daysBetween = (to, from) => {
  return toMoment(to).diff(toMoment(from), 'days')
}

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

const formatDateToMonthYear = (date = now()) => {
  return moment(date).format(monthYearFormat)
}

export {
  now,
  addMonths,
  daysBetween,
  parseFromISO8601,
  formatDate,
  formatDateToISO8601,
  formatDateToMonthYear,
  parseAndFormatDate,
}
