import { Record } from 'immutable'

const subscriptionObject = {
  name: '',
  amount: '1',
  amount_currency: 'GBP',
  cycle: 'monthly',
}

const SubscriptionRecord = Record(subscriptionObject)

class Subscription extends SubscriptionRecord {
  // Extend immutable js Record
}

export function parseSubscription(object) {
  return new Subscription(object)
}

export default Subscription
