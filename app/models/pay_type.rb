# == Schema Information
#
# Table name: pay_types
#
#  id         :integer          not null, primary key
#  pay_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PayType < ActiveRecord::Base
	has_many :orders
end
