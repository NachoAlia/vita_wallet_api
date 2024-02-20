class Api::V1::PriceController < ApplicationController 
  include ChartPrice
  
  def index  
    render json: { bitcoin_price: ChartPrice.get_btc_price() }
  end

end 