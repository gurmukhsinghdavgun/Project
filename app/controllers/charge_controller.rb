class ChargeController < ApplicationController

  before_action :authenticate_recruiter!

  def pay

    @amount = 100

    profile = Profile.find(params[:profile_id])

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => profile.name,
      :currency    => 'gbp'
    )

    if charge
      current_recruiter.devpurchaseds.create(profile: profile)
      redirect_to profile
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to profile
  end

end
