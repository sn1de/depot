class PriceLineItems < ActiveRecord::Migration
  def up
    LineItem.all.each do |l|
      l.price = Product.find_by(id: l.product_id).price
      l.save!
    end
  end

  def down
    LineItem.all.each do |l|
      l.price = nil
      l.save
    end
  end
end
