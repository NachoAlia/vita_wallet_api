require 'rails_helper'

RSpec.describe "Transactions", type: :request do
    include ChartPrice
    puts "Transactions test"

    def authenticate_user(email, password)
      post '/api/v1/login', params: { email: email, password: password }
      JSON.parse(response.body)['token']
    end

    def create_deposit(token, amount)
      post '/api/v1/deposit', params: { amount: amount }, headers: { 'Authorization' => "Bearer #{token}" }
    end

    def create_purchase(token, currency_from, currency_to, amount)
      post '/api/v1/purchase', params: { currency_from: currency_from, currency_to: currency_to, amount: amount }, headers: { 'Authorization' => "Bearer #{token}" }
    end
    
    def create_sale(token, currency_from, currency_to, amount)
        post '/api/v1/purchase', params: { currency_from: currency_from, currency_to: currency_to, amount: amount }, headers: { 'Authorization' => "Bearer #{token}" }
    end
    
    describe "POST /api/v1/purchase" do
        let(:user) { create(:user) }
    
        it 'Crea una nueva transaccion de compra con credenciales validas' do
            token = authenticate_user(user.email, 'secretpassword')
            create_deposit(token, 1000.00)
            create_purchase(token, 'USD', 'BTC', 100)

            btc_price = ChartPrice.get_btc_price('USD')
            balance = user.user_balances.find_by(currency: 'BTC').amount

            expect(response).to have_http_status(:created)
            expect(balance).==((1000.00 / btc_price).round(8))

            transaction = user.transactions.last
            expect(transaction.transaction_type).to eq('purchase')
        end
    
        it 'No crea una nueva transaccion de compra con credenciales invalidas' do
            authenticate_user(user.email, 'invalid')

            create_purchase(nil, 'USD', 'BTC', 100)

            expect(response).to have_http_status(:unauthorized)
            expect(user.transactions.count).to eq(0)
        end
    
        it 'No crea una nueva transaccion de compra con fondos insuficientes' do
            token = authenticate_user(user.email, 'secretpassword')

            create_purchase(token, 'USD', 'BTC', 100)

            expect(response).to have_http_status(:unprocessable_entity)
            expect(user.transactions.count).to eq(0)
        end
    end
    
    describe "POST /api/v1/sale" do
        let(:user) { create(:user) }

        it 'Crea una nueva transaccion de venta con credenciales validas' do
            token = authenticate_user(user.email, 'secretpassword')
            create_deposit(token, 1000.00)
            create_purchase(token, 'USD', 'BTC', 1000.0)
            
            balance_usd_before_sale = user.user_balances.find_by(currency: 'USD').amount
            balance_btc_before_sale = user.user_balances.find_by(currency: 'BTC').amount
            
            expect(balance_usd_before_sale) == (0.0)
            expect(balance_btc_before_sale) == (1000.0 / ChartPrice.get_btc_price('USD'))
            
            create_sale(token, 'BTC', 'USD', 1000.0)
            
            balance_usd_after_sale = user.user_balances.find_by(currency: 'USD').amount
            balance_btc_after_sale = user.user_balances.find_by(currency: 'BTC').amount
            
            expect(balance_usd_after_sale) == (balance_usd_before_sale)
            expect(balance_btc_after_sale) == 0.0

            transaction = user.transactions.last
            expect(transaction.transaction_type) == ('sale')
        end
    
    end

    describe "GET /api/v1/users/:user_id/transactions" do
        let(:user) { create(:user) }

        it 'Retorna todas las transacciones del usuario' do
            token = authenticate_user(user.email, 'secretpassword')
            create_deposit(token, 1000.00)
            create_purchase(token, 'USD', 'BTC', 1000.0)
        
            get "/api/v1/users/#{user.id}/transactions", headers: { 'Authorization' => "Bearer #{token}" }
        
            expect(response).to have_http_status(:success)
            
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq(1)

            json_response.each do |transaction|
              expect(transaction['user_id']).to eq(user.id)
            end
        end

        it 'Retorna todas las transacciones del usuario que no tiene transacciones' do
            token = authenticate_user(user.email, 'secretpassword')
        
            get "/api/v1/users/#{user.id}/transactions", headers: { 'Authorization' => "Bearer #{token}" }
        
            expect(response).to have_http_status(:success)
            
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq(0)
        end
    
    end

    describe "GET /api/v1/transactions/:id" do
        let(:user) { create(:user) }

        it 'Retorna una transaccion especifica' do
            token = authenticate_user(user.email, 'secretpassword')
            get "/api/v1/transactions/123", headers: { 'Authorization' => "Bearer #{token}" }
            expect(response).to have_http_status(:not_found)
            
            create_deposit(token, 1000.00)
            create_purchase(token, 'USD', 'BTC', 1000.0)
            transaction = user.transactions.last
            
            get "/api/v1/transactions/#{transaction.id}", headers: { 'Authorization' => "Bearer #{token}" }
        
            expect(response).to have_http_status(:success)
            json_response = JSON.parse(response.body)
            expect(json_response['id']).to eq(transaction.id)
            expect(json_response['amount'])==(transaction.amount)
            
        end
    end
end