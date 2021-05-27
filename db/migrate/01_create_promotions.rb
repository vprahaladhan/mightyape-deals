class CreatePromotions < ActiveRecord::Migration[4.2]

  def change
    create_table :promotions do |t|
      t.string :title
      t.string :link
      t.integer :num_of_products
      t.string :expiry
      t.timestamps
    end
  end

end