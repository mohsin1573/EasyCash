class TransactionsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @transaction = Transaction.new
    end
  
    def create
      @transaction = current_user.transactions.build(transaction_params)
      @transaction.account = current_user.account
    
      if @transaction.save
        if @transaction.transaction_type == "Deposit"
          current_user.account.update(balance: current_user.account.balance + @transaction.amount)
        elsif @transaction.transaction_type == "Withdraw"
          current_balance = current_user.account.balance
          if current_balance >= @transaction.amount
            current_user.account.update(balance: current_balance - @transaction.amount)
          else
            flash[:alert] = "Insufficient balance."
            redirect_to new_transaction_path and return
          end
        end
    
        redirect_to transactions_path, notice: 'Transaction successfully processed.'
      else
        render :new
      end
    end
    
  
    def index
      @transactions = current_user.transactions.order(created_at: :desc)
    end
  
    private
  
    def transaction_params
      params.require(:transaction).permit(:transaction_type, :amount)
    end
  end
  