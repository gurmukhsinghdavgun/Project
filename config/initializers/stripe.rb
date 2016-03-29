Rails.configuration.stripe = {
  :publishable_key => 'pk_test_o9FMz5iI1OrU4H0mNewJrF5P',
  :secret_key      => 'sk_test_IJ0dEej0YxMw672Lv2yMQVNf'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
