class Api::V1::RevenueController < ApplicationController

  def show
    revenue = Merchant.total_revenue(revenue_params).first
  
    render json: RevenueSerializer.new(revenue)
  end

  private

  def revenue_params
    params.permit(:end, :start)
  end

end