class Payment < ActiveRecord::Base
  
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year # not storing these in our model, but need to get them from form
  belongs_to :user
  
  def self.month_options
    return Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end
  
  def self.year_options
    return (Date.today.year ..(Date.today.year+10)).to_a # next 10 years as an array
  end
  
  def process_payment
    customer = Stripe::Customer.create email: email, card: token
    Stripe::Charge.create customer: customer.id, amount: 1000, description: 'Premium', currency: 'usd' # amount is in cents
  end
  
end
