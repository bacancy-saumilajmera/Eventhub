class ChargesController < ApplicationController

  def new
    @registration = Registration.where(event_id: params[:id], user_id: current_user.id)
  end
  
  def create
    # Amount in cents
    @registration = Registration.where(event_id: params[:id], user_id: current_user.id)
    @amount = @registration[0][:total_amount]
    @registration[0].update(status: true)
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken]})

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount*100,
      description: 'Rails Stripe customer',
      currency: 'inr'
      })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  redirect_to root_path
end
