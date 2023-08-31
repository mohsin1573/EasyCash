class TransactionMailer < ApplicationMailer
    def transaction_notification(user, transaction, account)
      @user = user
      @transaction = transaction
      @account = account
      mail(to: @user.email, subject: 'Transaction Notification')
    end
  end
  