class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :payment_type

      t.timestamps
    end
  end
end
