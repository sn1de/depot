class PriceLineItems < ActiveRecord::Migration
  #def up
  #  LineItem.all.each do |l|
  #    l.price = Product.find_by(id: l.product_id).price
  #    l.save!
  #  end
  #end
  #
  #def down
  #  LineItem.all.each do |l|
  #    l.price = nil
  #    l.save
  #  end
  #end
  def self.up
    add_column :line_items, :price, :decimal,

    say_with_time "Updating prices..." do
      LineItem.find(:all).each do |lineitem|
        lineitem.update_attribute :price, lineitem.product.price
      end
    end
  end

  def self.down
    remove_column :line_items, :price
  end

end
