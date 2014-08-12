# == Schema Information
#
# Table name: payment_types
#
#  id           :integer          not null, primary key
#  payment_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class PaymentTypes < ActiveRecord::Base
	has_many :orders
end
