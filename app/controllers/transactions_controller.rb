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
            @transaction.destroy # Rollback the saved transaction
            render :new and return
          end
        end
        # Enqueue the email notification job
        TransactionMailer.transaction_notification(current_user, @transaction, current_user.account).deliver_now
        redirect_to transactions_path, notice: 'Transaction successfully processed.'
      else
        flash[:alert] = "Transaction couldn't be saved."
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
  