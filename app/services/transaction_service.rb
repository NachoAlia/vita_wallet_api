module TransactionService 
    include ChartPrice
    
    def self.perform_transaction(user, currency_from, currency_to, amount, transaction_type)
        from_balance = user.user_balances.find_or_create_by(currency: currency_from)

        if from_balance && from_balance.can_deduct?(amount.to_f)
          
            received_amount = self.calculate_received_amount(currency_from, currency_to, amount.to_f)
            return nil if received_amount.nil?
            
            from_balance.deduct(amount.to_f)
            
            to_balance = user.user_balances.find_or_create_by(currency: currency_to)
            to_balance.add(received_amount)
        
            transaction = user.transactions.create!(
                currency_from: currency_from,
                currency_to: currency_to,
                amount: amount.to_f,
                transaction_type: transaction_type
            )
            
            return transaction
        else
            return nil
        end
    end

    private
    def self.calculate_received_amount(currency_from, currency_to, amount)
        if (currency_from == 'BTC' && currency_to == 'BTC')
            received_amount = amount.to_f / 1.0.to_f   
        elsif (currency_from == 'BTC')
            conversion_rate = ChartPrice.get_btc_price(currency_to)
            received_amount = amount.to_f * conversion_rate.to_f
            received_amount = received_amount.round(2)
        elsif (currency_to == 'BTC')
            conversion_rate = ChartPrice.get_btc_price(currency_from)
            received_amount = amount.to_f / conversion_rate.to_f   
        else 
            reseived_amount = nil
        end
        received_amount
    end
    
end