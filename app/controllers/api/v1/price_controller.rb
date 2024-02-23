class Api::V1::PriceController < ApplicationController 
  include ChartPrice
  skip_before_action :authenticate_user!, only: [:index]
  def index  
    render json: { bitcoin_price: ChartPrice.get_btc_price }
  end

end 