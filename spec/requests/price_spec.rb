require 'rails_helper'

RSpec.describe "Prices", type: :request do
    include ChartPrice
    puts "Index test"
    
    describe "GET /api/v1" do
        it 'Verifica precio de bitcoin' do
            get '/api/v1/'
            json_response = JSON.parse(response.body)
            expect(json_response['btc_price']) == ChartPrice.get_btc_price
        end
    end
end