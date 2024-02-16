class Api::V1::PriceController < ApplicationController 
    
    def get_btc_price
        connection = Faraday.new(url: 'https://api.coindesk.com/v1/bpi/currentprice.json') do |faraday|
          faraday.adapter Faraday.default_adapter
        end
    
        response = connection.get
        bitcoin_price = JSON.parse(response.body)['bpi']['USD']['rate']

        render json: { bitcoin_price: bitcoin_price }
        
    end

end 