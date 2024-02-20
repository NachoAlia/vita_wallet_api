module ChartPrice
    require 'json'
    
    def self.get_btc_price
        connection = Faraday.new(url: 'https://api.coindesk.com/v1/bpi/currentprice.json') do |faraday|
            faraday.adapter Faraday.default_adapter
          end
      
        response = connection.get
        bitcoin_price = JSON.parse(response.body)['bpi']['USD']['rate']
        bitcoin_price
    end
end 