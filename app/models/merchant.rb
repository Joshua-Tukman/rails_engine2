class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy

  def self.top_earners
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .where("transactions.result = 'success'")
            .group('merchants.id')
            .select('merchants.id, merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .order('revenue DESC')
            .limit(params[:quantity].to_i)
  end

  def self.total_revenue(dates)
  
    times = dates[:start].to_date.beginning_of_day..dates[:end].to_date.end_of_day
    # total = InvoiceItem.select('invoice_items.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    #                    .joins(invoices: [:transactions])
    #                    .group('invoice_items.id')
    #                    .where(transactions: { result: "success" })
    #                    .where(created_at: times)

    total = Invoice.select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
                   .joins(:invoice_items, :transactions)
                   .where(transactions: { result: "success" })
                   .where(created_at: times)
  end
end
