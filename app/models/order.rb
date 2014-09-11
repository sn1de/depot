# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  address     :text
#  email       :string(255)
#  pay_type_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  ship_date   :date
#

class Order < ActiveRecord::Base
  belongs_to :pay_type
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]

  validates :name, :address, :email, presence: true
 # validates :pay_type, inclusion: PAYMENT_TYPES
  validates_presence_of :pay_type

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end
end
