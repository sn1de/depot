class ShipDateNotification < ActionMailer::Base
  default from: "the.brad.schneider@gmail.com"

  def ship_changed(order)
  	@order = order

  	mail to: @order.email, subject: "Shipping Date Change"
  end
end
