class Api::V1::TransactionsController < ApplicationController

    def purchase  
        render_transaction_response(:purchase)
    end 
    
    def sale  
        render_transaction_response(:sale)
    end 

    def show 
        transaction = Transaction.find_by(id: params[:id])
        if transaction
            render json: transaction, status: :ok
        else 
            render json: { error: 'Transaction not found' }, status: :not_found
        end
    end

    def list_transactions
        user = User.find_by(id: params[:user_id])
        if user 
            render json: user.transactions, status: :ok
        else 
            render json: { error: 'User not found' }, status: :not_found
        end
    end 

    def deposit 
        deposit = UserBalance.deposit(current_user.id, 'USD', params[:amount])
    
        if deposit
            render json: deposit, status: :created
        else
            render json: { error: 'Unable to process the transaction' }, status: :unprocessable_entity
        end 
    end 
    
    private 
    
    def render_transaction_response(transaction_type)
        transaction = TransactionService.perform_transaction(current_user, params[:currency_from], params[:currency_to], params[:amount], transaction_type)
        
        if transaction 
          render json: transaction, status: :created
        else 
          render json: { error: 'Unable to process the transaction' }, status: :unprocessable_entity
        end
    end
end 