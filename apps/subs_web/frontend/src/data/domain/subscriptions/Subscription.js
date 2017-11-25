import { Record } from 'immutable'

import { parseAndFormatDate } from 'utils/dt'
import colors from 'constants/colors'

const remoteData = {
  id: null,
  name: '',
  color: colors.default,
  description: null,
  amount: '1',
  cycle: 'monthly',
  amount_currency: 'GBP',
  amount_currency_symbol: null,
  first_bill_date: null,
  next_bill_date: null,
}

const SubscriptionRecord = Record(remoteData)

class Subscription extends SubscriptionRecord {
  // Extend immutable js Record
  get humanFirstBillDate() {
    return parseAndFormatDate(this.first_bill_date)
  }

  get humanNextBillDate() {
    return parseAndFormatDate(this.next_bill_date)
  }

  get textColor() {
    return colors.textColorForBg[this.color]
  }
}

export function parseSubscription(data) {
  return new Subscription(data)
}

export default Subscription
