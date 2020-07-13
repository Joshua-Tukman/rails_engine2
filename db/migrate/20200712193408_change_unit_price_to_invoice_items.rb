class ChangeUnitPriceToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :unit_price, :integer 
    add_column :invoice_items, :unit_price, :float
  end
end
