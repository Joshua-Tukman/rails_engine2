class ChangeUnitPriceToItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :unit_price, :integer 
    add_column :items, :unit_price, :float
  end
end
