module ChartPrice
    require 'json'
    
    def self.get_btc_price(currency='USD')
        if currency == 'BTC'
            return 1.0
        else
            connection = Faraday.new(url: 'https://api.coindesk.com/v1/bpi/currentprice.json') do |faraday|
                faraday.adapter Faraday.default_adapter
            end
        
            response = connection.get
            bitcoin_price = JSON.parse(response.body)['bpi'][currency]['rate']

            bitcoin_price = bitcoin_price.gsub(',', '').to_f
            
            bitcoin_price
        end
    end
end 