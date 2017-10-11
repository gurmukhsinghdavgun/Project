Rails.configuration.stripe = {
  :publishable_key => 'KEYHERE',
  :secret_key      => 'KEYSHERE'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
