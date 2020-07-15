
desc "Import CSV files"
namespace :db do
  task :import_csv => [:environment] do 

    
    info = {Customer => "./db/csvs/customers.csv", 
            Merchant => "./db/csvs/merchants.csv", 
            Invoice => "./db/csvs/invoices.csv", 
            Item => "./db/csvs/items.csv",
            InvoiceItem => "./db/csvs/invoice_items.csv",
            Transaction => "./db/csvs/transactions.csv"}
    
    
    info.each do |object, path|   
      object.destroy_all  
      CSV.foreach(path, headers: true) do |row|
        if row["unit_price"]
          row["unit_price"] = row["unit_price"].to_f / 100
        end
        object.create! row.to_hash
      end
     #object.reset_pk_sequence (This is the gem that will automatically fix the primary key conflict)
     ActiveRecord::Base.connection.reset_pk_sequence!("#{object}")
    end 
  end
end